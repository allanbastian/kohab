import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kohab/core/components/date_selector.dart';
import 'package:kohab/core/components/my_loading_indicator.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/presentation/blocs/habits_cubit.dart';
import 'package:kohab/features/habits/presentation/widgets/habit_list.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final HabitsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _cubit = context.read<HabitsCubit>()..getAllUserHabits();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const DateSelector(),
        const SizedBox(height: 12),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text('All')),
            Tab(child: Text('Personal')),
            Tab(child: Text('Group')),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildHabitTab(
                emptyMessage: 'Start adding habits to track them!',
                habitSelector: (state) => state.habits,
                useConsumer: true,
              ),
              _buildHabitTab(
                emptyMessage: 'Start adding personal habits to track them!',
                habitSelector: (state) => state.personalHabits,
              ),
              _buildHabitTab(
                emptyMessage: 'Start adding habits with friends to track them!',
                habitSelector: (state) => state.collabHabits,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHabitTab({
    required String emptyMessage,
    required List<HabitEntity> Function(HabitsLoaded) habitSelector,
    bool useConsumer = false,
  }) {
    Widget builder(BuildContext context, HabitsState state) {
      if (state is HabitsLoading || state is HabitsInitial) {
        return const MyLoadingIndicator();
      }
      if (state is HabitsLoaded) {
        final habits = habitSelector(state);
        if (habits.isEmpty) {
          return Center(child: Text(emptyMessage));
        }
        return HabitList(habits: habits);
      }
      return const SizedBox.shrink();
    }

    if (useConsumer) {
      return BlocConsumer<HabitsCubit, HabitsState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is HabitsLoadingError) {
            MySnackbar.displayErrorMessage(state.error, context);
          }
        },
        builder: builder,
      );
    }

    return BlocBuilder<HabitsCubit, HabitsState>(
      bloc: _cubit,
      builder: builder,
    );
  }
}
