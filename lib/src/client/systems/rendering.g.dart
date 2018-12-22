// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rendering.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$EntityRenderingSysteme extends EntityProcessingSystem {
  Mapper<Transform> transformMapper;
  Mapper<BodyDef> bodyDefMapper;
  _$EntityRenderingSysteme()
      : super(Aspect.empty()..allOf([Transform, BodyDef]));
  @override
  void initialize() {
    super.initialize();
    transformMapper = Mapper<Transform>(world);
    bodyDefMapper = Mapper<BodyDef>(world);
  }
}

abstract class _$HealthBarRenderingSystem extends EntityProcessingSystem {
  Mapper<Health> healthMapper;
  Mapper<HealthBar> healthBarMapper;
  _$HealthBarRenderingSystem()
      : super(Aspect.empty()..allOf([Health, HealthBar]));
  @override
  void initialize() {
    super.initialize();
    healthMapper = Mapper<Health>(world);
    healthBarMapper = Mapper<HealthBar>(world);
  }
}
