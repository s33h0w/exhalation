/// Bubble 气泡
/// 唯一的可操作单位，也是积雨云形成所需的最小单位
class Bubble {
  String id;
  String name; // 名称
  int hours; // 小时数
  bool vaporized; // 是否已汽化

  Bubble(this.name, this.hours, this.vaporized) {
    final now = DateTime.now().toString();
    this.id = name + now;
  }
}

/// Cumulonimbus 积雨云
/// 气泡上升后累积形成积雨云
class Cumulonimbus {
  String name;
  int goal;
  List<Bubble> bubbleList;

  Cumulonimbus(this.name, this.goal, this.bubbleList);

  addBubble(Bubble bubble) {
    this.bubbleList.add(bubble);
  }
}

// 充满积雨云的天空
List<Cumulonimbus> cloudySky = [];

// 气泡聚集的大气层
List<Bubble> atmosphere = [];

// 创建新的Bubble
Bubble createBubble(String name, int hours, [bool vaporized]) {
  final defaultVaporized = false;
  final bubble =
      Bubble(name, hours, vaporized != null ? vaporized : defaultVaporized);

  atmosphere.add(bubble);

  return bubble;
}

// 汽化Bubble
void vaporizeBubble(Bubble bubble) {
  bubble.vaporized = true;
  atmosphere.remove(bubble);

  bool cumuExist(Cumulonimbus cumu) {
    return cumu.name == bubble.name;
  }

  final Cumulonimbus cumu = cloudySky.firstWhere(cumuExist, orElse: () => null);

  if (cumu != null) {
    cumu.addBubble(bubble);
  } else {
    cloudySky.add(Cumulonimbus(bubble.name, 100, [bubble]));
  }
}

// 删除Bubble
void deleteBubble(Bubble bubble) {
  atmosphere.remove(bubble);
}
