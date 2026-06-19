class SearchScriptDataModel {
  SearchScriptDataModel({
    required this.success,
    required this.message,
    required this.storedCount,
    required this.segments,
  });

  final bool success;
  final String message;
  final int storedCount;
  final List<String> segments;

  factory SearchScriptDataModel.fromJson(Map<String, dynamic> json){
    return SearchScriptDataModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      storedCount: json["storedCount"] ?? 0,
      segments: json["segments"] == null ? [] : List<String>.from(json["segments"]!.map((x) => x)),
    );
  }

}

/*
{
	"success": true,
	"message": "Data already available in memory",
	"storedCount": 22339,
	"segments": [
		"NSE",
		"BSE"
	]
}*/