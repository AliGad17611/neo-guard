import 'package:flutter/material.dart';
import '../game/components/weapon_system.dart';

class WeaponSelector extends StatelessWidget {
  final int currentWave;
  final WeaponType selectedWeapon;
  final Function(WeaponType) onWeaponSelected;
  final VoidCallback onClose;

  const WeaponSelector({
    super.key,
    required this.currentWave,
    required this.selectedWeapon,
    required this.onWeaponSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final unlockedWeapons = WeaponRegistry.getUnlockedWeapons(currentWave);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2845).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00D4FF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SELECT WEAPON',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weapon grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: unlockedWeapons.length,
            itemBuilder: (context, index) {
              final weapon = unlockedWeapons[index];
              final isSelected = weapon.type == selectedWeapon;

              return _buildWeaponCard(weapon, isSelected);
            },
          ),

          const SizedBox(height: 8),
          Text(
            'Unlocked: ${unlockedWeapons.length}/6 weapons',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaponCard(WeaponData weapon, bool isSelected) {
    return GestureDetector(
      onTap: () => onWeaponSelected(weapon.type),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? weapon.color.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? weapon.color : Colors.white24,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: weapon.glowColor.withValues(alpha: 0.5),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: weapon.color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(weapon.icon, color: weapon.color, size: 32),
            ),
            const SizedBox(height: 8),

            // Name
            Text(
              weapon.name,
              style: TextStyle(
                color: isSelected ? weapon.color : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildStatRow(
                    'DMG',
                    '${weapon.getDamage(currentWave)}',
                    weapon.color,
                  ),
                  if (weapon.projectileCount > 1)
                    _buildStatRow(
                      'SHOTS',
                      '${weapon.projectileCount}x',
                      weapon.color,
                    ),
                  if (weapon.pierceCount > 0)
                    _buildStatRow(
                      'PIERCE',
                      '${weapon.pierceCount}',
                      weapon.color,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white60, fontSize: 9)),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact weapon selector button for HUD
class WeaponSelectorButton extends StatelessWidget {
  final WeaponType currentWeapon;
  final VoidCallback onTap;

  const WeaponSelectorButton({
    super.key,
    required this.currentWeapon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final weapon = WeaponRegistry.getWeapon(currentWeapon);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: weapon.color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: weapon.color, width: 2),
          boxShadow: [
            BoxShadow(
              color: weapon.glowColor.withValues(alpha: 0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(weapon.icon, color: weapon.color, size: 20),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weapon.name.toUpperCase(),
                  style: TextStyle(
                    color: weapon.color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'TAP TO CHANGE',
                  style: TextStyle(color: Colors.white70, fontSize: 8),
                ),
              ],
            ),
            const SizedBox(width: 6),
            Icon(Icons.swap_horiz, color: weapon.color, size: 16),
          ],
        ),
      ),
    );
  }
}
