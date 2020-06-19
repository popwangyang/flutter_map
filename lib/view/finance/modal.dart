
class StatisticalModal {

  StatisticalItem signStatistics;
  StatisticalItem implementStatistics;
  StatisticalItem cdnStatistics;
  StatisticalItem scanStatistics;

  StatisticalModal({
    this.cdnStatistics,
    this.implementStatistics,
    this.scanStatistics,
    this.signStatistics
  });

  StatisticalModal.fromJson(Map<String, dynamic> json){
    this.cdnStatistics = StatisticalItem(
      ktvCount: json['cdn_statistics']['ktv_annotate_city_count'],
      roomCount: json['cdn_statistics']['ktv_annotate_room_count'],
      lastWeekKtvGrow: json['cdn_grow']['ktv_group_city_count'],
      lastWeekRoomGrow: json['cdn_grow']['ktv_annotate_room_count']
    );
    this.implementStatistics = StatisticalItem(
        ktvCount: json['implement_statistics']['ktv_annotate_city_count'],
        roomCount: json['implement_statistics']['ktv_annotate_room_count'],
        lastWeekKtvGrow: json['implement_grow']['ktv_group_city_count'],
        lastWeekRoomGrow: json['implement_grow']['ktv_annotate_room_count']
    );
    this.scanStatistics = StatisticalItem(
        ktvCount: json['scan_statistics']['ktv_annotate_city_count'],
        roomCount: json['scan_statistics']['ktv_annotate_room_count'],
        lastWeekKtvGrow: json['scan_grow']['ktv_group_city_count'],
        lastWeekRoomGrow: json['scan_grow']['ktv_annotate_room_count']
    );
    this.signStatistics = StatisticalItem(
        ktvCount: json['sign_statistics']['ktv_annotate_city_count'],
        roomCount: json['sign_statistics']['ktv_annotate_room_count'],
        lastWeekKtvGrow: json['sign_grow']['ktv_group_city_count'],
        lastWeekRoomGrow: json['sign_grow']['ktv_annotate_room_count']
    );
  }

  static StatisticalModal init(){
    return StatisticalModal(
      cdnStatistics: StatisticalItem.init(),
      scanStatistics: StatisticalItem.init(),
      implementStatistics: StatisticalItem.init(),
      signStatistics: StatisticalItem.init()
    );
  }


}

class StatisticalItem {
  int ktvCount;
  int roomCount;
  int lastWeekKtvGrow;
  int lastWeekRoomGrow;

  StatisticalItem({
    this.ktvCount = 0,
    this.roomCount = 0,
    this.lastWeekKtvGrow = 0,
    this.lastWeekRoomGrow = 0
  });

  static StatisticalItem init(){
    return StatisticalItem(ktvCount: 0, roomCount: 0, lastWeekRoomGrow: 0,lastWeekKtvGrow: 0);
  }

}