// import 'package:flutter/material.dart';

// class HomePageClaude extends StatefulWidget {
//   const HomePageClaude({super.key});
//   @override
//   State<HomePageClaude> createState() => _HomePageClaudeState();
// }

// class _HomePageClaudeState extends State<HomePageClaude> {
//   bool _notifVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<AppState>();
//     final cs = Theme.of(context).colorScheme;
//     final tt = Theme.of(context).textTheme;
//     final now = DateTime.now();
//     final income = state.monthlyTotal(TransactionType.income);
//     final expense = state.monthlyTotal(TransactionType.expense);
//     final recent = state.recentTransactions;
//     final pieData = state.expenseByCategory();

//     final overBudget = state.budgets.where((b) => b.isWarning).toList();

//     return Scaffold(
//       backgroundColor: cs.surface,
//       body: CustomScrollView(
//         slivers: [
//           // ── Hero SliverAppBar ─────────────────────────────────────────────
//           SliverAppBar(
//             expandedHeight: 220,
//             pinned: true,
//             stretch: true,
//             backgroundColor: AppColors.slate800,
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.pin,
//               background: _HeroHeader(
//                 income: income,
//                 expense: expense,
//                 balance: state.totalBalance,
//                 month: now,
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),

//                 // ── Alert banner ────────────────────────────────────────────
//                 if (_notifVisible && overBudget.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: _AlertBanner(
//                       budget: overBudget.first,
//                       category: state.categoryById(overBudget.first.categoryId),
//                       onDismiss: () => setState(() => _notifVisible = false),
//                     ),
//                   ),

//                 if (_notifVisible && overBudget.isNotEmpty)
//                   const SizedBox(height: 20),

//                 // ── Quick actions ────────────────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: _QuickActions(state: state),
//                 ),
//                 const SizedBox(height: 28),

//                 // ── Pie chart ────────────────────────────────────────────────
//                 if (pieData.isNotEmpty) ...[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: _SectionHeader(
//                       title: 'Gastos por categoria',
//                       action: 'Ver tudo',
//                       onAction: () {},
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: _PieCard(pieData: pieData, state: state),
//                   ),
//                   const SizedBox(height: 28),
//                 ],

//                 // ── Orçamentos ───────────────────────────────────────────────
//                 if (state.budgets.isNotEmpty) ...[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: _SectionHeader(
//                       title: 'Orçamentos do mês',
//                       action: 'Gerenciar',
//                       onAction: () {},
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: _BudgetsCard(state: state),
//                   ),
//                   const SizedBox(height: 28),
//                 ],

//                 // ── Últimas transações ───────────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: _SectionHeader(
//                     title: 'Últimas transações',
//                     action: 'Ver todas',
//                     onAction: () {},
//                   ),
//                 ),
//                 if (recent.isEmpty)
//                   const EmptyState(
//                     emoji: '💸',
//                     title: 'Nenhuma transação',
//                     subtitle:
//                         'Toque em + para lançar\nsua primeira despesa ou receita',
//                   )
//                 else
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: recent
//                           .take(5)
//                           .map(
//                             (t) => Padding(
//                               padding: const EdgeInsets.only(bottom: 8),
//                               child: TransactionTile(
//                                 transaction: t,
//                                 category: state.categoryById(t.categoryId),
//                                 onDelete: () => state.deleteTransaction(t.id),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 const SizedBox(height: 100),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const AddTransactionPage()),
//         ),
//         backgroundColor: AppColors.green700,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: const Icon(Icons.add_rounded, size: 26),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Hero Header
// // ─────────────────────────────────────────────────────────────────────────────

// class _HeroHeader extends StatelessWidget {
//   final double income, expense, balance;
//   final DateTime month;
//   const _HeroHeader({
//     required this.income,
//     required this.expense,
//     required this.balance,
//     required this.month,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [AppColors.slate800, Color(0xFF162032)],
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top row
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         fmtMonth(month).toUpperCase(),
//                         style: const TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: .1,
//                           color: Colors.white54,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       const Text(
//                         'Olá, Calebe 👋',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                           letterSpacing: -.3,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [AppColors.green700, AppColors.teal600],
//                       ),
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: AppColors.green500.withOpacity(.35),
//                         width: 2,
//                       ),
//                     ),
//                     child: const Center(
//                       child: Text('💰', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Balance
//               const Text(
//                 'Saldo total',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: .1,
//                   color: Colors.white45,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 fmtCurrency(balance),
//                 style: AppTextTheme.amount(
//                   fontSize: 36,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Income / Expense pills
//               Row(
//                 children: [
//                   _SummaryPill(
//                     label: 'Receitas',
//                     amount: income,
//                     isIncome: true,
//                   ),
//                   const SizedBox(width: 10),
//                   _SummaryPill(
//                     label: 'Despesas',
//                     amount: expense,
//                     isIncome: false,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SummaryPill extends StatelessWidget {
//   final String label;
//   final double amount;
//   final bool isIncome;
//   const _SummaryPill({
//     required this.label,
//     required this.amount,
//     required this.isIncome,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = isIncome ? AppColors.green500 : const Color(0xFFEF4444);
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(.06),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white.withOpacity(.09)),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 isIncome
//                     ? Icons.arrow_downward_rounded
//                     : Icons.arrow_upward_rounded,
//                 color: color,
//                 size: 16,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label.toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 9,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: .08,
//                     color: Colors.white45,
//                   ),
//                 ),
//                 const SizedBox(height: 1),
//                 Text(
//                   fmtCurrency(amount),
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     letterSpacing: -.4,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Alert Banner
// // ─────────────────────────────────────────────────────────────────────────────

// class _AlertBanner extends StatelessWidget {
//   final Budget budget;
//   final Category? category;
//   final VoidCallback onDismiss;
//   const _AlertBanner({
//     required this.budget,
//     this.category,
//     required this.onDismiss,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFEF3C7),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.amber500.withOpacity(.25)),
//       ),
//       child: Row(
//         children: [
//           const Text('⚠️', style: TextStyle(fontSize: 20)),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Orçamento de ${category?.name ?? 'categoria'} em atenção',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF92400E),
//                   ),
//                 ),
//                 Text(
//                   '${(budget.percentage * 100).toStringAsFixed(0)}% do limite mensal utilizado',
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: Color(0xFFB45309),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: onDismiss,
//             child: Container(
//               width: 22,
//               height: 22,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFB45309).withOpacity(.12),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.close_rounded,
//                 size: 12,
//                 color: Color(0xFF92400E),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Quick Actions
// // ─────────────────────────────────────────────────────────────────────────────

// class _QuickActions extends StatelessWidget {
//   final AppState state;
//   const _QuickActions({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final actions = [
//       (
//         icon: Icons.add_rounded,
//         label: 'Lançar',
//         bg: AppColors.greenTint,
//         fg: AppColors.green700,
//       ),
//       (
//         icon: Icons.bar_chart_rounded,
//         label: 'Relatórios',
//         bg: const Color(0xFFDBEAFE),
//         fg: AppColors.blue500,
//       ),
//       (
//         icon: Icons.track_changes_rounded,
//         label: 'Orçamentos',
//         bg: const Color(0xFFFEF3C7),
//         fg: AppColors.amber500,
//       ),
//       (
//         icon: Icons.account_balance_wallet_outlined,
//         label: 'Contas',
//         bg: const Color(0xFFF3E8FF),
//         fg: const Color(0xFFA855F7),
//       ),
//     ];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _SectionHeader(title: 'Ações rápidas', onAction: null),
//         const SizedBox(height: 12),
//         Row(
//           children: actions
//               .map(
//                 (a) => Expanded(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 52,
//                           height: 52,
//                           decoration: BoxDecoration(
//                             color: a.bg,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Icon(a.icon, color: a.fg, size: 22),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           a.label,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.slate500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Pie Chart Card
// // ─────────────────────────────────────────────────────────────────────────────

// class _PieCard extends StatefulWidget {
//   final Map<String, double> pieData;
//   final AppState state;
//   const _PieCard({required this.pieData, required this.state});
//   @override
//   State<_PieCard> createState() => _PieCardState();
// }

// class _PieCardState extends State<_PieCard> {
//   int _touched = -1;

//   @override
//   Widget build(BuildContext context) {
//     final entries = widget.pieData.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));
//     final total = entries.fold(0.0, (s, e) => s + e.value);

//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.black.withOpacity(.04)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 110,
//             height: 110,
//             child: PieChart(
//               PieChartData(
//                 pieTouchData: PieTouchData(
//                   touchCallback: (_, r) => setState(() {
//                     _touched = r?.touchedSection?.touchedSectionIndex ?? -1;
//                   }),
//                 ),
//                 sectionsSpace: 2,
//                 centerSpaceRadius: 32,
//                 sections: entries.asMap().entries.map((e) {
//                   final cat = widget.state.categoryById(e.value.key);
//                   final touched = e.key == _touched;
//                   return PieChartSectionData(
//                     color: cat?.color ?? AppColors.slate300,
//                     value: e.value.value,
//                     radius: touched ? 42 : 34,
//                     title: touched
//                         ? '${(e.value.value / total * 100).toStringAsFixed(0)}%'
//                         : '',
//                     titleStyle: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           const SizedBox(width: 18),
//           Expanded(
//             child: Column(
//               children: entries.take(5).map((e) {
//                 final cat = widget.state.categoryById(e.key);
//                 final pct = (e.value / total * 100).toStringAsFixed(0);
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: cat?.color ?? AppColors.slate300,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           cat?.name ?? e.key,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.slate800,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text(
//                         '$pct%',
//                         style: const TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.slate500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Budgets Card
// // ─────────────────────────────────────────────────────────────────────────────

// class _BudgetsCard extends StatelessWidget {
//   final AppState state;
//   const _BudgetsCard({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final budgets = state.budgets.take(3).toList();
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.black.withOpacity(.04)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: budgets.asMap().entries.map((entry) {
//           final i = entry.key;
//           final b = entry.value;
//           final cat = state.categoryById(b.categoryId);
//           final color = b.isOver
//               ? AppColors.danger
//               : b.isWarning
//               ? AppColors.amber500
//               : AppColors.green700;

//           return Column(
//             children: [
//               if (i > 0) ...[
//                 const Divider(height: 20),
//               ],
//               Row(
//                 children: [
//                   Container(
//                     width: 28,
//                     height: 28,
//                     decoration: BoxDecoration(
//                       color: AppColors.slate100,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Text(
//                         cat?.icon ?? '📦',
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       cat?.name ?? 'Categoria',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.slate800,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     fmtCurrency(b.spentAmount),
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: color,
//                     ),
//                   ),
//                   Text(
//                     ' / ${fmtCurrency(b.limitAmount)}',
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: AppColors.slate500,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 7),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: LinearProgressIndicator(
//                   value: b.percentage,
//                   minHeight: 6,
//                   backgroundColor: color.withOpacity(.12),
//                   valueColor: AlwaysStoppedAnimation(color),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Section Header
// // ─────────────────────────────────────────────────────────────────────────────

// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final String? action;
//   final VoidCallback? onAction;
//   const _SectionHeader({required this.title, this.action, this.onAction});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: AppTextTheme.sectionTitle.copyWith(color: AppColors.slate800),
//         ),
//         const Spacer(),
//         if (action != null)
//           GestureDetector(
//             onTap: onAction,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 '$action →',
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.green700,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// // ── Aliases para evitar import duplicado ─────────────────────────────────────
// const slate500 = Color(0xFF6B7280);
// const slate300 = Color(0xFFD1D5DB);
// const slate100 = Color(0xFFF3F4F6);
// const slate800 = Color(0xFF1F2937);
// const amber500 = Color(0xFFF59E0B);
// const blue500 = Color(0xFF3B82F6);
