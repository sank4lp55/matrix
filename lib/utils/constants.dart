class ImageConstants {
  static const Map<String, String> images = {
    'image107': 'https://i.pinimg.com/564x/94/aa/e2/94aae2ac078a605b534ed7b86b423792.jpg',
    'image67': 'https://i.pinimg.com/564x/19/20/35/192035ec162c6dbe9c455f31c349c3fb.jpg',
    'image64': 'https://i.pinimg.com/564x/54/be/b5/54beb5877059ac99517784c3961325cf.jpg',
    'image95': 'https://i.pinimg.com/564x/73/dd/63/73dd630a91defba5843e2222bc064971.jpg',
    'image104': 'https://i.pinimg.com/564x/8c/5d/64/8c5d643d2fab87333250067d22fafec5.jpg',
    'image68': 'https://i.pinimg.com/564x/c6/7f/4c/c67f4c98d5949709bb85ae8904b9acd9.jpg',
    'image121': 'https://i.pinimg.com/564x/2a/94/f7/2a94f71fc5fb379b013511c3b044a1d9.jpg',
    'image126': 'https://i.pinimg.com/564x/63/db/a8/63dba8890f6e77f4a22bf3e9095ad768.jpg',
    'image128': 'https://i.pinimg.com/564x/03/8c/5e/038c5e5d0f40991297a7fc7a0680d756.jpg',
  };

  static String getImageUrl(String imageName) {
    return images[imageName] ?? 'Image not found';
  }

  static const String onboardingImage="assets/Fusion festival 2009.jpeg";
  static const String namedLogo='assets/icons/logo_named.svg';
  static const String dummyQr="assets/qr.png";
}