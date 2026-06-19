class PositionDataModel {
  PositionDataModel({
    required this.message,
    required this.results,
  });

  final String? message;
  final List<Result> results;

  factory PositionDataModel.fromJson(Map<String, dynamic> json){
    return PositionDataModel(
      message: json["message"],
      results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

}

class Result {
  Result({
    required this.data,
  });

  final List<PositionData> data;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      data: json["data"] == null ? [] : List<PositionData>.from(json["data"]!.map((x) => PositionData.fromJson(x))),
    );
  }

}

class PositionData {
  PositionData({
     this.symboltoken ="",
     this.symbolname ="",
     this.instrumenttype ="",
     this.priceden ="",
     this.pricenum ="",
     this.genden ="",
     this.gennum ="",
     this.precision ="",
     this.multiplier ="",
     this.boardlotsize ="",
     this.exchange ="",
     this.producttype ="",
     this.tradingsymbol ="",
     this.symbolgroup ="",
     this.strikeprice ="",
     this.optiontype ="",
     this.expirydate ="",
     this.lotsize ="",
     this.cfbuyqty ="",
     this.cfsellqty ="",
     this.cfbuyamount ="",
     this.cfsellamount ="",
     this.buyavgprice ="",
     this.sellavgprice ="",
     this.avgnetprice ="",
     this.netvalue ="",
     this.netqty ="",
     this.totalbuyvalue ="",
     this.totalsellvalue ="",
     this.cfbuyavgprice ="",
     this.cfsellavgprice ="",
     this.totalbuyavgprice ="",
     this.totalsellavgprice ="",
     this.netprice ="",
     this.buyqty ="",
     this.sellqty ="",
     this.buyamount ="",
     this.sellamount ="",
     this.pnl ="",
     this.realised ="",
     this.unrealised ="",
     this.ltp ="",
     this.close ="",
     this.client ="",
  });

   String symboltoken;
   String symbolname;
   String instrumenttype;
   String priceden;
   String pricenum;
   String genden;
   String gennum;
   String precision;
   String multiplier;
   String boardlotsize;
   String exchange;
   String producttype;
   String tradingsymbol;
   String symbolgroup;
   String strikeprice;
   String optiontype;
   String expirydate;
   String lotsize;
   String cfbuyqty;
   String cfsellqty;
   String cfbuyamount;
   String cfsellamount;
   String buyavgprice;
   String sellavgprice;
   String avgnetprice;
   String netvalue;
   String netqty;
   String totalbuyvalue;
   String totalsellvalue;
   String cfbuyavgprice;
   String cfsellavgprice;
   String totalbuyavgprice;
   String totalsellavgprice;
   String netprice;
   String buyqty;
   String sellqty;
   String buyamount;
   String sellamount;
   String pnl;
   String realised;
   String unrealised;
   String ltp;
   String close;
   String client;

  factory PositionData.fromJson(Map<String, dynamic> json){
    return PositionData(
      symboltoken: json["symboltoken"] ??"",
      symbolname: json["symbolname"] ??"",
      instrumenttype: json["instrumenttype"]??"",
      priceden: json["priceden"]??"",
      pricenum: json["pricenum"]??"",
      genden: json["genden"] ??"",
      gennum: json["gennum"] ??"",
      precision: json["precision"] ??"",
      multiplier: json["multiplier"] ??"",
      boardlotsize: json["boardlotsize"] ??"",
      exchange: json["exchange"] ??"",
      producttype: json["producttype"] ??"",
      tradingsymbol: json["tradingsymbol"] ??"",
      symbolgroup: json["symbolgroup"] ??"",
      strikeprice: json["strikeprice"] ??"",
      optiontype: json["optiontype"] ??"",
      expirydate: json["expirydate"] ??"",
      lotsize: json["lotsize"] ??"",
      cfbuyqty: json["cfbuyqty"] ??"",
      cfsellqty: json["cfsellqty"] ??"",
      cfbuyamount: json["cfbuyamount"] ??"",
      cfsellamount: json["cfsellamount"] ??"",
      buyavgprice: json["buyavgprice"] ??"",
      sellavgprice: json["sellavgprice"] ??"",
      avgnetprice: json["avgnetprice"] ??"",
      netvalue: json["netvalue"] ??"",
      netqty: json["netqty"] ??"",
      totalbuyvalue: json["totalbuyvalue"] ??"",
      totalsellvalue: json["totalsellvalue"] ??"",
      cfbuyavgprice: json["cfbuyavgprice"] ??"",
      cfsellavgprice: json["cfsellavgprice"] ??"",
      totalbuyavgprice: json["totalbuyavgprice"] ??"",
      totalsellavgprice: json["totalsellavgprice"] ??"",
      netprice: json["netprice"]??"",
      buyqty: json["buyqty"] ??"",
      sellqty: json["sellqty"] ??"",
      buyamount: json["buyamount"] ??"",
      sellamount: json["sellamount"] ??"",
      pnl: json["pnl"] ??"",
      realised: json["realised"] ??"",
      unrealised: json["unrealised"]??"",
      ltp: json["ltp"] ??"",
      close: json["close"]??"",
      client: json["client"]??"",
    );
  }

}
