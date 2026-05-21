import 'package:flutter/material.dart';
import '../../widgets/mission_card.dart';

enum MissionStatus { disponible, completada, bloqueada }

class MissionNode {
  final String title;
  final String description;
  final MissionStatus status;

  const MissionNode({
    required this.title,
    required this.description,
    this.status = MissionStatus.disponible,
  });
}

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  static const List<MissionNode> _missions = [
    MissionNode(
      title: "Nodo Alpha",
      description: "Hackear servidor de notas",
    ),
    MissionNode(
      title: "Nodo Beta",
      description: "Interceptar señal de radio",
      status: MissionStatus.bloqueada,
    ),
    MissionNode(
      title: "Nodo Gamma",
      description: "Sabotaje de drones",
      status: MissionStatus.completada,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MISSION NODES"),
      ),
      body: _missions.isEmpty
          ? const Center(
              child: Text("// Sin misiones disponibles"),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _missions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final mission = _missions[index];
                return MissionCard(
                  title: mission.title,
                  description: mission.description,
                  status: mission.status,
                  onTap: mission.status == MissionStatus.disponible
                      ? () => _onMissionTap(context, mission)
                      : null,
                );
              },
            ),
    );
  }

  void _onMissionTap(BuildContext context, MissionNode mission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(">> Iniciando: ${mission.title}"),
        backgroundColor: Colors.greenAccent.withOpacity(0.15),
      ),
    );
  }
}