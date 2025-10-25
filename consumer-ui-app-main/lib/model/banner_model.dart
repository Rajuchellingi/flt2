List<BannerVWModel> bannerListFromJson(dynamic str) =>
    List<BannerVWModel>.from(str.map((x) => BannerVWModel.fromPkModel(x)));

class BannerVWModel {
  final String id;
  final String description;
  final String imageName;
  final String link;
  final String mobileImageName;
  final num sortOrder;
  final String title;
  final bool status;

  BannerVWModel(this.id, this.description, this.imageName, this.link,
      this.mobileImageName, this.sortOrder, this.title, this.status);

  BannerVWModel.fromPkModel(dynamic json)
      : id = json.id,
        description = json.description,
        imageName = json.imageName,
        link = json.link,
        mobileImageName = json.mobileImageName,
        sortOrder = json.sortOrder,
        title = json.title,
        status = json.status;
}

class ImageSliderVWModel {
  final String id;
  final String imageName;
  final String? link;
  final String? kind;
  final String? title;

  ImageSliderVWModel(this.id, this.imageName, this.link, this.kind, this.title);

  ImageSliderVWModel.fromPkModel(dynamic json)
      : id = json.id,
        imageName = json.imageName,
        kind = json.kind,
        link = json.link != null ? json.link : '',
        title = json.title ?? "";
}
