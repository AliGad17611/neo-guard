import 'package:flutter/material.dart';
import '../game/components/cannon_upgrade_system.dart';
import '../game/components/weapon_system.dart';

class GameHUD extends StatelessWidget {
  final int score;
  final int combo;
  final int health;
  final int wave;
  final bool shieldActive;
  final double shieldCooldown;
  final VoidCallback onPause;
  final VoidCallback onShield;
  final CannonUpgradeSystem? cannonUpgrades;
  final WeaponType? currentWeapon;
  final VoidCallback? onWeaponSelect;

  const GameHUD({
    super.key,
    required this.score,
    required this.combo,
    required this.health,
    required this.wave,
    required this.shieldActive,
    required this.shieldCooldown,
    required this.onPause,
    required this.onShield,
    this.cannonUpgrades,
    this.currentWeapon,
    this.onWeaponSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Health bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PLANET',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              widthFactor: health / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: health > 50
                                        ? [Colors.green, Colors.lightGreen]
                                        : health > 25
                                        ? [Colors.orange, Colors.yellow]
                                        : [Colors.red, Colors.redAccent],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '$health/100',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 2),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Score and combo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'SCORE: $score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (combo > 0)
                      Text(
                        'COMBO x$combo',
                        style: const TextStyle(
                          color: Color(0xFFFF006E),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Wave and pause
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00D4FF),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'WAVE $wave',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onPause,
                  icon: const Icon(
                    Icons.pause_circle_filled,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            // Weapon Selector
            if (currentWeapon != null && onWeaponSelect != null) ...[
              const SizedBox(height: 12),
              _buildWeaponSelectorButton(),
            ],
            const Spacer(),
            // Shield Button
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: shieldCooldown <= 0 && !shieldActive ? onShield : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: shieldActive
                          ? const LinearGradient(
                              colors: [Color(0xFF00FFD4), Color(0xFF00D4FF)],
                            )
                          : shieldCooldown > 0
                          ? LinearGradient(
                              colors: [
                                Colors.grey.shade700,
                                Colors.grey.shade600,
                              ],
                            )
                          : const LinearGradient(
                              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: shieldActive
                              ? const Color(0xFF00FFD4).withValues(alpha: 0.5)
                              : shieldCooldown > 0
                              ? Colors.transparent
                              : const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.shield,
                          size: 40,
                          color: shieldCooldown > 0 && !shieldActive
                              ? Colors.white30
                              : Colors.white,
                        ),
                        if (shieldCooldown > 0 && !shieldActive)
                          Positioned(
                            bottom: 8,
                            child: Text(
                              '${shieldCooldown.ceil()}s',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (shieldActive)
                          const Positioned(
                            bottom: 8,
                            child: Text(
                              'ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeaponSelectorButton() {
    final weapon = WeaponRegistry.getWeapon(currentWeapon!);

    return GestureDetector(
      onTap: onWeaponSelect,
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
            const SizedBox(width: 8),
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
                Row(
                  children: [
                    Text(
                      'DMG: ${weapon.getDamage(wave)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 9,
                      ),
                    ),
                    if (weapon.projectileCount > 1) ...[
                      const Text(
                        ' • ',
                        style: TextStyle(color: Colors.white70, fontSize: 9),
                      ),
                      Text(
                        '${weapon.projectileCount}x',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(Icons.swap_horiz, color: weapon.color, size: 16),
          ],
        ),
      ),
    );
  }
}
