import 'package:scmp_mobile_assg/models/staff.dart';

class StaffListResponse {
    final int page;
    final int perPage;
    final int total;
    final int totalPages;
    final List<Staff> data;
    final StaffListResponseSupport support;

    StaffListResponse({
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
        required this.data,
        required this.support,
    });

    factory StaffListResponse.fromJson(Map<String, dynamic> json) {
        return StaffListResponse(
            page: json['page'],
            perPage: json['per_page'],
            total: json['total'],
            totalPages: json['total_pages'],
            data: (json['data'] as List)
                    .map((e) => Staff.fromJson(e))
                    .toList(),
            support: StaffListResponseSupport.fromJson(json['support']),
        );
    }

    toJson() {
        return {
            'page': page,
            'per_page': perPage,
            'total': total,
            'total_pages': totalPages,
            'data': data.map((e) => e.toJson()).toList(),
            'support': support.toJson(),
        };
    }

  StaffListResponse copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<Staff>? data,
    StaffListResponseSupport? support,
  }) {
    return StaffListResponse(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      data: data ?? this.data,
      support: support ?? this.support,
    );
  }
}

class StaffListResponseSupport {
    final String url;
    final String text;

    StaffListResponseSupport({
        required this.url,
        required this.text,
    });

    factory StaffListResponseSupport.fromJson(Map<String, dynamic> json) {
        return StaffListResponseSupport(
            url: json['url'],
            text: json['text'],
        );
    }

    toJson() {
        return {
            'url': url,
            'text': text,
        };
    }
}
