import 'package:flutter/material.dart';

// 좋아요 버튼을 만들기 위해 StatefulWidget을 상속 받습니다.
class LikeButton extends StatefulWidget {
  // 생성자: 위젯을 만들 때 호출됩니다.
  LikeButton({super.key});

	  // State를 연결합니다. State에 모든 역할을 위임.
  @override
  LikeButtonState createState() => LikeButtonState();
}

// 좋아요 상태를 관리하기 위해 State를 상속 받습니다.
class LikeButtonState extends State<LikeButton> {

  // 좋아요 상태를 나타내는 변수입니다.
  bool _isLiked = false;

  // 화면에 그릴 UI를 정의합니다.
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite, // 하트 모양 아이콘입니다.
        color: _isLiked ? Colors.red : Colors.grey, // 좋아요 여부에 따라 색상이 바뀝니다.
      ),
      onPressed: () {
        // setState를 통해 상태가 변했음을 알려줍니다.
        setState(() {
          _isLiked = !_isLiked; // 좋아요 상태를 업데이트 합니다.
        });
      },
    );
  }
}