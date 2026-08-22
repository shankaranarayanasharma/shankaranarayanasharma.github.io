import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/screens/project_detail/project_media_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsBody extends StatefulWidget {
  final Project project;
  final bool isMobile;
  final VoidCallback? onClose;
  final List<Project>? allProjects;
  final bool usePointByPointUI;

  const ProjectDetailsBody({
    Key? key,
    required this.project,
    required this.isMobile,
    this.onClose,
    this.allProjects,
    this.usePointByPointUI = false,
  }) : super(key: key);

  @override
  State<ProjectDetailsBody> createState() => _ProjectDetailsBodyState();
}

class _ProjectDetailsBodyState extends State<ProjectDetailsBody> {
  late Project _currentProject;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project;
  }

  @override
  void didUpdateWidget(covariant ProjectDetailsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.project != widget.project) {
      setState(() {
        _currentProject = widget.project;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Project> get _projectsList {
    if (widget.allProjects != null && widget.allProjects!.isNotEmpty) {
      return widget.allProjects!;
    }
    return PortfolioData.projectsJson
        .map((json) => Project.fromJson(json))
        .toList();
  }

  void _switchProject(Project newProject) {
    setState(() {
      _currentProject = newProject;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = _projectsList;
    final currentIndex =
        list.indexWhere((p) => p.title == _currentProject.title);
    final prevIndex =
        currentIndex > 0 ? currentIndex - 1 : list.length - 1;
    final nextIndex = (currentIndex + 1) % list.length;

    final prevProject = list.isNotEmpty ? list[prevIndex] : null;
    final nextProject = list.isNotEmpty ? list[nextIndex] : null;

    final effectiveIsMobile =
        widget.isMobile || MediaQuery.of(context).size.width < 900;

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cinematic Hero Banner ────────────────────────
          _HeroBanner(
            project: _currentProject,
            onClose: widget.onClose,
            isMobile: effectiveIsMobile,
            onScrollDown: () {
              if (_scrollController.hasClients) {
                final targetOffset = effectiveIsMobile ? 380.0 : 480.0;
                _scrollController.animateTo(
                  targetOffset,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                );
              }
            },
          ),

          // ── Body Content ─────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: effectiveIsMobile ? 18.0 : 48.0,
              vertical: 36.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Grid Narrative Layout ─────────────────
                _GridNarrativeSection(
                  project: _currentProject,
                  isMobile: effectiveIsMobile,
                  usePointByPointUI: widget.usePointByPointUI,
                ),

                const SizedBox(height: 36),

                // ── Engineering Challenges ─────────────────
                if (_currentProject.hasEngineeringChallenges) ...[
                  const _SectionHeader(
                    label: "Engineering Challenges",
                    icon: Icons.developer_board_rounded,
                  ),
                  const SizedBox(height: 20),
                  _EngineeringChallengesSection(
                    challenges: _currentProject.engineeringChallenges,
                    isMobile: effectiveIsMobile,
                  ),
                  const SizedBox(height: 36),
                ],

                // ── Media & Gallery ────────────────────────
                _SectionHeader(
                    label: AppStrings.mediaAndGallery,
                    icon: Icons.photo_library_rounded),
                const SizedBox(height: 20),
                ProjectMediaCarousel(
                  media: _currentProject.media,
                  mediaByPlatform: _currentProject.mediaByPlatform,
                  projectImage: _currentProject.image,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          // ── Bottom Project Switcher (Prev / Next) ─────────
          if (prevProject != null && nextProject != null && list.length > 1)
            _ProjectFooterSwitcher(
              prevProject: prevProject,
              nextProject: nextProject,
              onSelectProject: _switchProject,
              isMobile: effectiveIsMobile,
            ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════
// BOTTOM PROJECT FOOTER SWITCHER (IMAGE DESIGN)
// ═════════════════════════════════════════════════════════
class _ProjectFooterSwitcher extends StatelessWidget {
  final Project prevProject;
  final Project nextProject;
  final Function(Project) onSelectProject;
  final bool isMobile;

  const _ProjectFooterSwitcher({
    Key? key,
    required this.prevProject,
    required this.nextProject,
    required this.onSelectProject,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101012),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Project Link
          Flexible(
            child: _NavProjectButton(
              project: prevProject,
              isNext: false,
              isMobile: isMobile,
              onTap: () => onSelectProject(prevProject),
            ),
          ),
          const SizedBox(width: 16),
          // Next Project Link
          Flexible(
            child: _NavProjectButton(
              project: nextProject,
              isNext: true,
              isMobile: isMobile,
              onTap: () => onSelectProject(nextProject),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavProjectButton extends StatefulWidget {
  final Project project;
  final bool isNext;
  final bool isMobile;
  final VoidCallback onTap;

  const _NavProjectButton({
    Key? key,
    required this.project,
    required this.isNext,
    required this.isMobile,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_NavProjectButton> createState() => _NavProjectButtonState();
}

class _NavProjectButtonState extends State<_NavProjectButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.project.title.toUpperCase();

    final circleBtn = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _hovered
            ? primaryColor.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.08),
        border: Border.all(
          color: _hovered
              ? primaryColor.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        widget.isNext
            ? Icons.arrow_forward_rounded
            : Icons.arrow_back_rounded,
        color: _hovered ? primaryColor : Colors.white,
        size: 18,
      ),
    );

    final titleText = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: _hovered ? primaryColor : Colors.white70,
        fontSize: widget.isMobile ? 11 : 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontFamily: 'monospace',
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.isNext ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: widget.isNext
              ? [
                  Flexible(child: titleText),
                  const SizedBox(width: 12),
                  circleBtn,
                ]
              : [
                  circleBtn,
                  const SizedBox(width: 12),
                  Flexible(child: titleText),
                ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════
// CINEMATIC HERO BANNER
// ═════════════════════════════════════════════════════════
class _HeroBanner extends StatelessWidget {
  final Project project;
  final bool isMobile;
  final VoidCallback? onClose;
  final VoidCallback? onScrollDown;

  const _HeroBanner({
    Key? key,
    required this.project,
    required this.isMobile,
    this.onClose,
    this.onScrollDown,
  }) : super(key: key);

  Widget _bg() {
    final img = project.image;
    final isAsset = img.startsWith('assets/');
    final child = isAsset
        ? Image.asset(img, fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _fallback())
        : Image.network(img, fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _fallback());
    return child;
  }

  Widget _fallback() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF1C2333)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final hPad = isMobile ? 20.0 : 56.0;
    final minHeight = isMobile ? 360.0 : 460.0;
    final category = project.categories.isNotEmpty
        ? project.categories.first.toUpperCase()
        : 'PROJECT';
    final platform = project.categories.join(' & ');

    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _bg(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.30),
                      Colors.black.withValues(alpha: 0.50),
                      Colors.black.withValues(alpha: 0.80),
                      Colors.black.withValues(alpha: 0.97),
                    ],
                    stops: const [0.0, 0.25, 0.65, 1.0],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.65],
                  ),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: hPad, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_GlassCloseButton(onClose: onClose)],
                ),
              ),
              SizedBox(height: isMobile ? 40 : 80),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$category',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: isMobile ? double.infinity : 620),
                      child: Text(
                        project.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 28 : 46,
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _ProjectTagPill(
                          icon: Icons.calendar_today_rounded,
                          label: project.displayYear,
                        ),
                        if (project.displayRole.isNotEmpty)
                          _ProjectTagPill(
                            icon: Icons.person_outline_rounded,
                            label: project.displayRole,
                          ),
                        ...project.displayTypes.map(
                          (type) => _ProjectTagPill(
                            icon: _getPlatformIcon(type),
                            label: type,
                          ),
                        ),
                      ],
                    ),
                    _QuickActionLinkButtons(project: project),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(right: hPad, bottom: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _ScrollDownDot(onTap: onScrollDown),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: hPad, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1),
                  ),
                  color: Colors.black.withValues(alpha: 0.40),
                ),
                child: isMobile
                    ? Wrap(
                        spacing: 28,
                        runSpacing: 18,
                        children: _metaItems(platform),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _metaItemsWithDividers(platform),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _metaItems(String platform) {
    final items = <Widget>[];

    final roleLabel = project.displayRole;
    if (roleLabel.isNotEmpty) {
      items.add(_MetaCol(
        label: 'ROLE',
        child: Text(
          roleLabel,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
      ));
    }

    if (platform.isNotEmpty) {
      items.add(_MetaCol(
        label: 'PLATFORM',
        child: Text(platform,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ));
    }

    if (project.technologies.isNotEmpty) {
      items.add(_MetaCol(
        label: 'TECH STACK',
        child: Wrap(
          spacing: 6,
          runSpacing: 4,
          children: project.technologies.take(6).map((t) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                    width: 0.8),
              ),
              child: Text(t,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11)),
            );
          }).toList(),
        ),
      ));
    }

    return items;
  }

  List<Widget> _metaItemsWithDividers(String platform) {
    final items = _metaItems(platform);
    final result = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      final wrapped = i == 0
          ? ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: items[i],
            )
          : items[i];
      result.add(wrapped);
      if (i < items.length - 1) {
        result.add(Container(
          height: 40,
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          color: Colors.white.withValues(alpha: 0.12),
        ));
      }
    }
    result.add(const Spacer());
    return result;
  }
}

class _ExpandableDescription extends StatefulWidget {
  final String text;

  const _ExpandableDescription({Key? key, required this.text})
      : super(key: key);

  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool _expanded = false;
  bool _btnHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > 110 || widget.text.contains('\n');

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 820),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              widget.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.5,
                height: 1.65,
                letterSpacing: 0.1,
              ),
            ),
            secondChild: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.5,
                height: 1.65,
                letterSpacing: 0.1,
              ),
            ),
          ),
          if (isLong) ...[
            const SizedBox(height: 6),
            MouseRegion(
              onEnter: (_) => setState(() => _btnHovered = true),
              onExit: (_) => setState(() => _btnHovered = false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expanded ? "See Less <<" : "See More >>",
                        style: TextStyle(
                          color: _btnHovered
                              ? const Color(0xFF60A5FA)
                              : const Color(0xFFF59E0B),
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetaCol extends StatelessWidget {
  final String label;
  final Widget child;
  const _MetaCol({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4,
            )),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _ScrollDownDot extends StatefulWidget {
  final VoidCallback? onTap;
  const _ScrollDownDot({Key? key, this.onTap}) : super(key: key);

  @override
  State<_ScrollDownDot> createState() => _ScrollDownDotState();
}

class _ScrollDownDotState extends State<_ScrollDownDot> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.13),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.30), width: 1.2),
          ),
          child: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _GlassCloseButton extends StatefulWidget {
  final VoidCallback? onClose;
  const _GlassCloseButton({this.onClose});

  @override
  State<_GlassCloseButton> createState() => _GlassCloseButtonState();
}

class _GlassCloseButtonState extends State<_GlassCloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onClose ?? () => Navigator.maybePop(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.11),
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.28), width: 1),
          ),
          child: Icon(
            widget.onClose != null
                ? Icons.close_rounded
                : Icons.arrow_back_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════
// GRID NARRATIVE SECTION
// ═════════════════════════════════════════════════════════
class _GridNarrativeSection extends StatelessWidget {
  final Project project;
  final bool isMobile;
  final bool usePointByPointUI;

  const _GridNarrativeSection({
    Key? key,
    required this.project,
    required this.isMobile,
    this.usePointByPointUI = false,
  }) : super(key: key);

  bool _hasBlocks(List<NarrativeBlock> blocks) => blocks.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final hasBackstory = _hasBlocks(project.backstoryBlocks);
    final hasApproach = _hasBlocks(project.approachBlocks);
    final hasRole = _hasBlocks(project.myRoleBlocks);
    final hasChallenge = _hasBlocks(project.challengeBlocks);
    final hasSolution = _hasBlocks(project.solutionBlocks);
    final hasOutcomes = _hasBlocks(project.keyOutcomesBlocks);
    final hasDifferent = _hasBlocks(project.whatMakesThisDifferentBlocks);
    final hasLearnings = _hasBlocks(project.whatITookFromItBlocks);

    bool usePt(String sectionKey) =>
        project.isSectionPointByPoint(sectionKey, usePointByPointUI);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.description.isNotEmpty) ...[
            _ExpandableDescription(text: project.description),
            const SizedBox(height: 28),
          ],
          if (hasBackstory)
            _TextNarrativeBlock(
              label: "THE BACKSTORY",
              icon: Icons.history_edu_rounded,
              blocks: project.backstoryBlocks,
              usePointByPoint: usePt('backstory'),
            ),
          if (hasApproach)
            _TextNarrativeBlock(
              label: "THE APPROACH",
              icon: Icons.alt_route_rounded,
              blocks: project.approachBlocks,
              usePointByPoint: usePt('approach'),
            ),
          if (hasRole)
            _CardNarrativeBlock(
              title: "My Role",
              icon: Icons.person_outline_rounded,
              iconColor: const Color(0xFF60A5FA),
              blocks: project.myRoleBlocks,
              usePointByPoint: usePt('myRole'),
            ),
          if (hasChallenge)
            _CardNarrativeBlock(
              title: "The Challenge",
              icon: Icons.warning_amber_rounded,
              iconColor: const Color(0xFFEF4444),
              blocks: project.challengeBlocks,
              usePointByPoint: usePt('challenge'),
            ),
          if (hasSolution)
            _CardNarrativeBlock(
              title: "The Solution",
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF38BDF8),
              blocks: project.solutionBlocks,
              usePointByPoint: usePt('solution'),
            ),
          if (hasOutcomes)
            _CardNarrativeBlock(
              title: "Key Outcomes",
              icon: Icons.emoji_events_outlined,
              iconColor: const Color(0xFFF59E0B),
              blocks: project.keyOutcomesBlocks,
              usePointByPoint: usePt('keyOutcomes'),
            ),
          if (hasDifferent)
            _TextNarrativeBlock(
              label: "WHAT MAKES THIS DIFFERENT",
              icon: Icons.adjust_rounded,
              accentColor: const Color(0xFF60A5FA),
              blocks: project.whatMakesThisDifferentBlocks,
              usePointByPoint: usePt('whatMakesThisDifferent'),
            ),
          if (hasLearnings)
            _TextNarrativeBlock(
              label: "KEY LEARNINGS",
              icon: Icons.school_outlined,
              accentColor: const Color(0xFF10B981),
              blocks: project.whatITookFromItBlocks,
              usePointByPoint: usePt('whatITookFromIt'),
            ),
        ],
      );
    }

    final hasLeftGroup = hasBackstory || hasApproach;
    final hasRightGroup = hasRole || hasChallenge;

    Widget buildLeftGroup() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasBackstory)
              _TextNarrativeBlock(
                label: "THE BACKSTORY",
                icon: Icons.history_edu_rounded,
                blocks: project.backstoryBlocks,
                usePointByPoint: usePt('backstory'),
              ),
            if (hasApproach)
              _TextNarrativeBlock(
                label: "THE APPROACH",
                icon: Icons.alt_route_rounded,
                blocks: project.approachBlocks,
                usePointByPoint: usePt('approach'),
              ),
          ],
        );

    Widget buildRightGroup() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasRole)
              _CardNarrativeBlock(
                title: "My Role",
                icon: Icons.person_outline_rounded,
                iconColor: const Color(0xFF60A5FA),
                blocks: project.myRoleBlocks,
                usePointByPoint: usePt('myRole'),
              ),
            if (hasChallenge)
              _CardNarrativeBlock(
                title: "The Challenge",
                icon: Icons.warning_amber_rounded,
                iconColor: const Color(0xFFEF4444),
                blocks: project.challengeBlocks,
                usePointByPoint: usePt('challenge'),
              ),
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.description.isNotEmpty) ...[
          _ExpandableDescription(text: project.description),
          const SizedBox(height: 32),
        ],
        if (hasLeftGroup && hasRightGroup)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildLeftGroup()),
              const SizedBox(width: 32),
              Expanded(child: buildRightGroup()),
            ],
          )
        else if (hasLeftGroup)
          buildLeftGroup()
        else if (hasRightGroup)
          buildRightGroup(),
        if (hasLeftGroup || hasRightGroup) const SizedBox(height: 16),
        if (hasSolution && hasOutcomes)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CardNarrativeBlock(
                  title: "The Solution",
                  icon: Icons.check_circle_outline_rounded,
                  iconColor: const Color(0xFF38BDF8),
                  blocks: project.solutionBlocks,
                  usePointByPoint: usePt('solution'),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _CardNarrativeBlock(
                  title: "Key Outcomes",
                  icon: Icons.emoji_events_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  blocks: project.keyOutcomesBlocks,
                  usePointByPoint: usePt('keyOutcomes'),
                ),
              ),
            ],
          )
        else if (hasSolution)
          _CardNarrativeBlock(
            title: "The Solution",
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF38BDF8),
            blocks: project.solutionBlocks,
            usePointByPoint: usePt('solution'),
          )
        else if (hasOutcomes)
          _CardNarrativeBlock(
            title: "Key Outcomes",
            icon: Icons.emoji_events_outlined,
            iconColor: const Color(0xFFF59E0B),
            blocks: project.keyOutcomesBlocks,
            usePointByPoint: usePt('keyOutcomes'),
          ),
        if (hasDifferent || hasLearnings) ...[
          const SizedBox(height: 16),
          if (hasDifferent)
            _TextNarrativeBlock(
              label: "WHAT MAKES THIS DIFFERENT",
              icon: Icons.adjust_rounded,
              accentColor: const Color(0xFF60A5FA),
              blocks: project.whatMakesThisDifferentBlocks,
              usePointByPoint: usePt('whatMakesThisDifferent'),
            ),
          if (hasLearnings)
            _TextNarrativeBlock(
              label: "KEY LEARNINGS",
              icon: Icons.school_outlined,
              accentColor: const Color(0xFF10B981),
              blocks: project.whatITookFromItBlocks,
              usePointByPoint: usePt('whatITookFromIt'),
            ),
        ],
      ],
    );
  }
}

class _BlockContentRenderer extends StatelessWidget {
  final List<NarrativeBlock> blocks;
  final Color accentColor;
  final bool forcePointByPoint;

  const _BlockContentRenderer({
    Key? key,
    required this.blocks,
    required this.accentColor,
    this.forcePointByPoint = false,
  }) : super(key: key);

  IconData _getIconForStyle(String? style) {
    if (style == 'check') return Icons.check_circle_outline_rounded;
    if (style == 'dash') return Icons.remove_rounded;
    if (style == 'star') return Icons.star_rounded;
    if (style == 'target') return Icons.adjust_rounded;
    if (style == 'bullet') return Icons.circle;
    return Icons.adjust_rounded;
  }

  Widget _buildSmartImage(String url, {BoxFit fit = BoxFit.cover}) {
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          height: 160,
          color: Colors.white.withValues(alpha: 0.05),
          child: const Center(
            child: Icon(Icons.image_outlined, color: Colors.white38),
          ),
        ),
      );
    }
    return Image.network(
      url,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        height: 160,
        color: Colors.white.withValues(alpha: 0.05),
        child: const Center(
          child: Icon(Icons.image_outlined, color: Colors.white38),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        switch (block.type) {
          case NarrativeBlockType.heading:
            if (block.text == null || block.text!.trim().isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
              child: Text(
                block.text!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  letterSpacing: -0.4,
                ),
              ),
            );

          case NarrativeBlockType.paragraph:
            if (block.text == null || block.text!.trim().isEmpty) {
              return const SizedBox();
            }
            if (forcePointByPoint) {
              final pts = _extractSentences(block.text!);
              return _buildPoints(pts, accentColor, null);
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                block.text!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  height: 1.7,
                ),
              ),
            );

          case NarrativeBlockType.points:
            if (block.items == null || block.items!.isEmpty) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildPoints(block.items!, accentColor, block.iconStyle),
            );

          case NarrativeBlockType.image:
            if (block.url == null || block.url!.isEmpty) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildSmartImage(block.url!),
                    ),
                  ),
                  if (block.caption != null && block.caption!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      block.caption!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            );

          case NarrativeBlockType.images:
            if (block.urls == null || block.urls!.isEmpty) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: block.urls!.map((u) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 180,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: _buildSmartImage(u),
                        ),
                      );
                    }).toList(),
                  ),
                  if (block.caption != null && block.caption!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      block.caption!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            );

          case NarrativeBlockType.video:
            if (block.url == null || block.url!.isEmpty) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF101014),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.movie_creation_outlined,
                            size: 60,
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: accentColor.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: accentColor,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (block.caption != null && block.caption!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      block.caption!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            );
        }
      }).toList(),
    );
  }

  Widget _buildPoints(List<String> items, Color tint, String? iconStyle) {
    final iconData = _getIconForStyle(iconStyle);
    final isDash = iconStyle == 'dash';
    final isNumber = iconStyle == 'number' || iconStyle == 'numbered';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final p = entry.value;

        Widget prefixWidget;
        if (isNumber) {
          prefixWidget = Text(
            "${index + 1}. ",
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.bold,
              fontSize: 13.5,
            ),
          );
        } else if (isDash) {
          prefixWidget = Text(
            "— ",
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
        } else {
          prefixWidget = Icon(
            iconData,
            color: tint,
            size: iconStyle == 'bullet' ? 6 : 15,
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isNumber || isDash
                      ? 2
                      : (iconStyle == 'bullet' ? 6 : 2),
                ),
                child: prefixWidget,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  p,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<String> _extractSentences(String text) {
    if (text.trim().isEmpty) return [];
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    if (lines.length > 1) {
      return lines
          .map((l) => l.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
          .where((l) => l.isNotEmpty)
          .toList();
    }
    if (text.contains(';')) {
      final semiSplit = text
          .split(';')
          .map((s) => s.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (semiSplit.length > 1) return semiSplit;
    }
    final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    final result = sentences
        .map((s) => s.replaceAll(RegExp(r'^[\s•\-\*\d+\.]+\s*'), '').trim())
        .where((s) => s.isNotEmpty)
        .toList();
    return result.isNotEmpty ? result : [text];
  }
}

class _TextNarrativeBlock extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<NarrativeBlock> blocks;
  final Color accentColor;
  final bool usePointByPoint;

  const _TextNarrativeBlock({
    Key? key,
    required this.label,
    required this.icon,
    required this.blocks,
    this.accentColor = const Color(0xFF60A5FA),
    this.usePointByPoint = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 15),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _CollapsibleContentBox(
            collapsedMaxHeight: 145,
            fadeColor: const Color(0xFF0D0D11),
            child: _BlockContentRenderer(
              blocks: blocks,
              accentColor: accentColor,
              forcePointByPoint: usePointByPoint,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardNarrativeBlock extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<NarrativeBlock> blocks;
  final bool usePointByPoint;

  const _CardNarrativeBlock({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.blocks,
    this.usePointByPoint = false,
  });

  @override
  State<_CardNarrativeBlock> createState() => _CardNarrativeBlockState();
}

class _CardNarrativeBlockState extends State<_CardNarrativeBlock> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBgColor =
        _hovered ? const Color(0xFF1F1F24) : const Color(0xFF161619);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.iconColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.iconColor.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: widget.iconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _CollapsibleContentBox(
              collapsedMaxHeight: 145,
              fadeColor: cardBgColor,
              child: _BlockContentRenderer(
                blocks: widget.blocks,
                accentColor: widget.iconColor,
                forcePointByPoint: widget.usePointByPoint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const _MeasureSize({Key? key, required this.child, required this.onChange})
      : super(key: key);

  @override
  State<_MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final size = context.size;
        if (size != null) {
          widget.onChange(size);
        }
      }
    });
    return widget.child;
  }
}

class _CollapsibleContentBox extends StatefulWidget {
  final Widget child;
  final double collapsedMaxHeight;
  final Color fadeColor;

  const _CollapsibleContentBox({
    Key? key,
    required this.child,
    this.collapsedMaxHeight = 160.0,
    this.fadeColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<_CollapsibleContentBox> createState() => _CollapsibleContentBoxState();
}

class _CollapsibleContentBoxState extends State<_CollapsibleContentBox> {
  bool _expanded = false;
  bool _btnHovered = false;
  double? _childHeight;

  @override
  Widget build(BuildContext context) {
    final isOverflowing = _childHeight != null &&
        _childHeight! > (widget.collapsedMaxHeight + 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: (!isOverflowing || _expanded)
              ? _MeasureSize(
                  onChange: (size) {
                    if (_childHeight != size.height) {
                      setState(() => _childHeight = size.height);
                    }
                  },
                  child: widget.child,
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: widget.collapsedMaxHeight,
                  ),
                  child: ClipRect(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: _MeasureSize(
                            onChange: (size) {
                              if (_childHeight != size.height) {
                                setState(() => _childHeight = size.height);
                              }
                            },
                            child: widget.child,
                          ),
                        ),
                        if (widget.fadeColor != Colors.transparent)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 36,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      widget.fadeColor.withValues(alpha: 0.0),
                                      widget.fadeColor.withValues(alpha: 0.95),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        if (isOverflowing) ...[
          const SizedBox(height: 8),
          MouseRegion(
            onEnter: (_) => setState(() => _btnHovered = true),
            onExit: (_) => setState(() => _btnHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  _expanded ? "See Less <<" : "See More >>",
                  style: TextStyle(
                    color: _btnHovered
                        ? const Color(0xFF60A5FA)
                        : const Color(0xFFF59E0B),
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SectionHeader({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                primaryColor.withValues(alpha: 0.4),
                Colors.transparent,
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

IconData _getPlatformIcon(String type) {
  final lower = type.toLowerCase();
  if (lower.contains('ipad') || lower.contains('tablet')) {
    return Icons.tablet_mac_rounded;
  }
  if (lower.contains('mobile') ||
      lower.contains('iphone') ||
      lower.contains('android') ||
      lower.contains('phone')) {
    return Icons.phone_iphone_rounded;
  }
  if (lower.contains('web') ||
      lower.contains('website') ||
      lower.contains('desktop')) {
    return Icons.devices_rounded;
  }
  return Icons.devices_rounded;
}

class _ProjectTagPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProjectTagPill({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: const Color(0xFF82ACF9),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _EngineeringChallengesSection extends StatelessWidget {
  final List<EngineeringChallenge> challenges;
  final bool isMobile;

  const _EngineeringChallengesSection({
    Key? key,
    required this.challenges,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: challenges.map((challenge) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _EngineeringChallengeCard(
            challenge: challenge,
            isMobile: isMobile,
          ),
        );
      }).toList(),
    );
  }
}

class _EngineeringChallengeCard extends StatefulWidget {
  final EngineeringChallenge challenge;
  final bool isMobile;

  const _EngineeringChallengeCard({
    Key? key,
    required this.challenge,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<_EngineeringChallengeCard> createState() =>
      _EngineeringChallengeCardState();
}

class _EngineeringChallengeCardState extends State<_EngineeringChallengeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;
    final hasRightContent = challenge.code != null ||
        challenge.image != null ||
        challenge.blocks.any((b) =>
            b.type == NarrativeBlockType.image ||
            b.type == NarrativeBlockType.images ||
            b.type == NarrativeBlockType.video);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(widget.isMobile ? 18 : 24),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF1F1F24) : const Color(0xFF161619),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF60A5FA).withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? const Color(0xFF60A5FA).withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header: [ 01 ] Title
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222228),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    challenge.number ?? '01',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    challenge.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.isMobile ? 16 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            const SizedBox(height: 20),

            // Layout Body: Desktop (2 Columns) / Mobile (Stacked)
            if (widget.isMobile || !hasRightContent) ...[
              _buildTextContent(challenge),
              if (hasRightContent) ...[
                const SizedBox(height: 20),
                _buildRightContent(challenge),
              ],
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildTextContent(challenge),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    flex: 6,
                    child: _buildRightContent(challenge),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(EngineeringChallenge challenge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (challenge.problem != null && challenge.problem!.isNotEmpty) ...[
          const Text(
            "THE PROBLEM",
            style: TextStyle(
              color: Color(0xFFF97316),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            challenge.problem!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
        ],
        if (challenge.approach != null && challenge.approach!.isNotEmpty) ...[
          const Text(
            "THE APPROACH",
            style: TextStyle(
              color: Color(0xFF60A5FA),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            challenge.approach!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
        ],
        if (challenge.blocks.isNotEmpty) ...[
          const SizedBox(height: 14),
          _BlockContentRenderer(
            blocks: challenge.blocks,
            accentColor: const Color(0xFF60A5FA),
          ),
        ],
      ],
    );
  }

  Widget _buildRightContent(EngineeringChallenge challenge) {
    if (challenge.code != null && challenge.code!.isNotEmpty) {
      return _CodeWindowWidget(
        code: challenge.code!,
        language: challenge.codeLanguage,
      );
    }
    if (challenge.image != null && challenge.image!.isNotEmpty) {
      final imgPath = challenge.image!;
      final isAsset = imgPath.startsWith('assets/');
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: isAsset
              ? Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: Colors.white.withValues(alpha: 0.05),
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: Colors.white38),
                    ),
                  ),
                )
              : Image.network(
                  imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: Colors.white.withValues(alpha: 0.05),
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: Colors.white38),
                    ),
                  ),
                ),
        ),
      );
    }
    return const SizedBox();
  }
}

class _CodeWindowWidget extends StatelessWidget {
  final String code;
  final String? language;

  const _CodeWindowWidget({
    Key? key,
    required this.code,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101014),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mac Window Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    _dot(const Color(0xFFFF5F56)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFFFFBD2E)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFF27C93F)),
                  ],
                ),
                const Spacer(),
                if (language != null && language!.isNotEmpty)
                  Text(
                    language!.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
              ],
            ),
          ),
          // Code Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText.rich(
                _highlightCode(code),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  TextSpan _highlightCode(String input) {
    final spans = <TextSpan>[];
    final lines = input.split('\n');

    final keywords = {
      'const', 'let', 'var', 'async', 'await', 'try', 'catch', 'function',
      'return', 'if', 'else', 'class', 'import', 'export', 'from', 'final',
      'void', 'throw', 'new', 'typedef', 'struct', 'enum'
    };

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trimLeft().startsWith('//')) {
        spans.add(TextSpan(
          text: line,
          style: const TextStyle(
            color: Color(0xFF6A9955),
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.5,
          ),
        ));
      } else {
        final words = line.split(RegExp(r'(?<=\s|\(|\)|\{|\}|\[|\]|;|,|\.)|(?=\s|\(|\)|\{|\}|\[|\]|;|,|\.)'));
        for (final word in words) {
          Color color = Colors.white70;
          FontWeight weight = FontWeight.normal;

          final trimmed = word.trim();
          if (keywords.contains(trimmed)) {
            color = const Color(0xFFFF79C6);
            weight = FontWeight.bold;
          } else if (RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
            color = const Color(0xFFBD93F9);
          } else if (trimmed.startsWith("'") || trimmed.startsWith('"')) {
            color = const Color(0xFFF1FA8C);
          } else if (trimmed == '=>' || trimmed == '=' || trimmed == '+' || trimmed == '-') {
            color = const Color(0xFFFF79C6);
          }

          spans.add(TextSpan(
            text: word,
            style: TextStyle(
              color: color,
              fontWeight: weight,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
            ),
          ));
        }
      }

      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return TextSpan(children: spans);
  }
}

class _QuickActionLinkButtons extends StatelessWidget {
  final Project project;

  const _QuickActionLinkButtons({Key? key, required this.project})
      : super(key: key);

  bool get hasLinks =>
      (project.appStore != null && project.appStore!.trim().isNotEmpty) ||
      (project.playStore != null && project.playStore!.trim().isNotEmpty) ||
      (project.github != null && project.github!.trim().isNotEmpty);

  @override
  Widget build(BuildContext context) {
    if (!hasLinks) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        children: [
          if (project.appStore != null && project.appStore!.trim().isNotEmpty)
            _ActionButton(
              label: "App Store",
              icon: Icons.apple,
              url: project.appStore!,
              accentColor: const Color(0xFF38BDF8),
            ),
          if (project.playStore != null && project.playStore!.trim().isNotEmpty)
            _ActionButton(
              label: "Google Play",
              icon: Icons.play_arrow_rounded,
              url: project.playStore!,
              accentColor: const Color(0xFF34D399),
            ),
          if (project.github != null && project.github!.trim().isNotEmpty)
            _ActionButton(
              label: "GitHub",
              icon: Icons.code_rounded,
              url: project.github!,
              accentColor: const Color(0xFFA78BFA),
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color accentColor;

  const _ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.url,
    required this.accentColor,
  }) : super(key: key);

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  void _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.accentColor.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accentColor.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? widget.accentColor : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? widget.accentColor : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_outward_rounded,
                size: 13,
                color: _hovered
                    ? widget.accentColor
                    : Colors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

