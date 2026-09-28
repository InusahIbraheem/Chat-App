import 'package:chat_ui/models/app_item.dart';

class DataService {
  static List<AppItem> get items => List.generate(8, (i) => AppItem(
        id: 'item_$i',
        title: 'Premium Item ${i + 1}',
        subtitle: 'Curated content for Chat UI',
        imageUrl: 'https://picsum.photos/seed/chat_ui$i/400/300',
      ));
}
