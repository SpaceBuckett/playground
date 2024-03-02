import 'package:firebase_database/firebase_database.dart';
import 'package:learning_ground/core/model/flower.dart';

class FirebaseDatabaseService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  storeflower(Flower flower) async {
    print('@storeflower');

    DatabaseReference flowerRef = ref.child('flowers');
    try {
      DatabaseReference newflowerRef = flowerRef.push();
      flower.flowerId = newflowerRef.key;

      await newflowerRef
          .set(flower.toJson())
          .then((value) => print('Saved Successfully'))
          .onError((error, stackTrace) {
        print('ERROR: $error');
      });
    } catch (error) {
      print('error: $error');
    }
  }

  Stream<List<Flower>> getflowersFromDatabase() {
    DatabaseReference flowersRef =
        FirebaseDatabase.instance.ref().child('flowers');
    return flowersRef.onValue.map(
      (event) {
        DataSnapshot dataSnapshot = event.snapshot;
        print(dataSnapshot.value);
        List<Flower> flowers = [];

        for (var element in dataSnapshot.children) {
          print('element: ${element.value}');
          flowers.add(Flower.fromJson(element.value));
        }

        return flowers;
      },
    );
  }

  updateLike(String flowerId, bool isLiked) async {
    DatabaseReference flowerRef = ref.child('flowers/$flowerId');

    await flowerRef.update(
      {
        'is_fav': isLiked,
      },
    );
  }
}
