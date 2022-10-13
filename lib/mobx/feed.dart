import 'package:appweb3603/components/post/widget_post.dart'; 
import 'package:appweb3603/entities/User.dart';
import 'package:mobx/mobx.dart';

part 'feed.g.dart';

class Feed = _Feed with _$Feed;

abstract class _Feed with Store{ 

  @observable 
  Observable<User> oCurrentUser = Observable( new User() );

  @observable 
  List<Post> oPosts = ObservableList<Post>();

  @action
  void setPost( Post post , { bool last = false} ){ 
    int pos = oPosts.length-1;
    
    if( pos < 0 ){
      pos = 0;  
    }

    oPosts.insert(last ? pos : 0, post );
  } 

  void setCurrentUser( User user ){
    oCurrentUser.value = user;
  }



}