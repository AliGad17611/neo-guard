import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import '../../domain/entities/asteroid_parameters.dart';

class InputPanel extends StatefulWidget {
  final Function(AsteroidParameters) onParametersChanged;
  final VoidCallback onLaunchImpact;
  final bool isCalculating;

  const InputPanel({
    super.key,
    required this.onParametersChanged,
    required this.onLaunchImpact,
    required this.isCalculating,
  });

  @override
  State<InputPanel> createState() => _InputPanelState();
}

class _InputPanelState extends State<InputPanel> {
  final _diameterController = TextEditingController();
  final _velocityController = TextEditingController();
  ImpactLocation _location = ImpactLocation.land;

  @override
  void initState() {
    super.initState();
    _diameterController.addListener(_updateParameters);
    _velocityController.addListener(_updateParameters);
  }

  void _updateParameters() {
    final diameter = double.tryParse(_diameterController.text) ?? 0;
    final velocity = double.tryParse(_velocityController.text) ?? 0;

    widget.onParametersChanged(AsteroidParameters(
      diameter: diameter,
      velocity: velocity,
      location: _location,
    ));
  }

  @override
  void dispose() {
    _diameterController.dispose();
    _velocityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.purple900.withValues(alpha:0.4),
            AppColors.blue800.withValues(alpha:0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.purple500.withValues(alpha:0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.gps_fixed,
                          color: AppColors.purple400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TARGETING',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.purple200,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      color: AppColors.green400,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Diameter Input
                _buildInputField(
                  label: 'ASTEROID DIAMETER',
                  controller: _diameterController,
                  unit: 'M',
                  hint: '100',
                ),
                const SizedBox(height: 20),

                // Velocity Input
                _buildInputField(
                  label: 'IMPACT VELOCITY',
                  controller: _velocityController,
                  unit: 'KM/S',
                  hint: '20',
                ),
                const SizedBox(height: 20),

                // Location Selector
                Text(
                  'IMPACT ZONE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.purple300,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildLocationOption(
                        label: 'LAND',
                        icon: Icons.public,
                        value: ImpactLocation.land,
                        color: AppColors.green400,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildLocationOption(
                        label: 'OCEAN',
                        icon: Icons.water,
                        value: ImpactLocation.ocean,
                        color: AppColors.blue400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Launch Button
                _buildLaunchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String unit,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.purple300,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha:0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.purple500.withValues(alpha:0.5),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: AppColors.purple400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 12,
                child: Text(
                  unit,
                  style: TextStyle(
                    color: AppColors.purple400,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationOption({
    required String label,
    required IconData icon,
    required ImpactLocation value,
    required Color color,
  }) {
    final isSelected = _location == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _location = value;
        });
        _updateParameters();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha:0.2)
              : Colors.black.withValues(alpha:0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : AppColors.purple500.withValues(alpha:0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaunchButton() {
    return GestureDetector(
      onTap: widget.isCalculating ? null : widget.onLaunchImpact,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: widget.isCalculating
              ? LinearGradient(
                  colors: [
                    AppColors.yellow400,
                    AppColors.orange500,
                  ],
                )
              : LinearGradient(
                  colors: [
                    AppColors.purple600,
                    AppColors.blue600,
                  ],
                ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple500.withValues(alpha:0.5),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isCalculating)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              Icon(Icons.flash_on, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              widget.isCalculating ? 'CALCULATING...' : 'LAUNCH SIMULATION',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}