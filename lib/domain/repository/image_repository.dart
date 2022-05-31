// Image Use Case will only depend on this repo to get image url
// In this way it will get url without knowing from where it is getting url
// It will provide abstraction and In future we don't need to change use case
// based on remote service or content
abstract class ImageRepository {
  // Get Image url to load image
  Future<String> fetchImageUrl();

  // Same Image to hive
  Future<void> saveImageUrl(String imageUrl);
  // Any other Image data related content
  // can be defined below

}
