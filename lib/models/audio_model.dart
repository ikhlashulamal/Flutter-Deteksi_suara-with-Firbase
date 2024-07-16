class AudioModel { //mendefinisikan model data train dari python yang sudah dibuat untukk merepresentasikan data audio dengan berbagai atribut seperti teks dan emosi
  String? id;
  String? text;
  String? angry;
  String? happy;
  String? neutral;
  String? sad;
  String? surprise;
  String? userId;

  AudioModel( //Konstruktor ini digunakan untuk membuat objek  baru dengan nilai-nilai yang sudah diberikan
      {required this.id,
      required this.text,
      required this.angry,
      required this.happy,
      required this.neutral,
      required this.userId,
      required this.sad,
      required this.surprise});

  AudioModel.fromJson({required Map<String, dynamic> map}) {//Metode ini adalah konstruktor tambahan yang membuat objek AudioModel dari sebuah peta 
    id = map["id"];
    text = map["text"];
    angry = map["angry"];
    happy = map["happy"];
    neutral = map["neutral"];
    sad = map["sad"];
    surprise = map["surprise"];
    userId = map["userId"];
  }

  Map<String, dynamic> toMap() {//metode ini jga berguna dalam aplikasi yang bekerja dengan data audio dan pengelolaan berbagai emosi yang terkandung dalam data training
    return {
      "id": id,
      "sad": sad,
      "angry": angry,
      "happy": happy,
      "neutral": neutral,
      "surprise": surprise,
      "text": text,
      "userId": userId,
    };
  }
}
