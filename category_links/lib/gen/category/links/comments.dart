part of category_links; 
 
// lib/gen/category/links/comments.dart 
 
abstract class CommentGen extends Entity<Comment> { 
 
  CommentGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  String get text => getAttribute("text"); 
  void set text(String a) { setAttribute("text", a); } 
  
  String get source => getAttribute("source"); 
  void set source(String a) { setAttribute("source", a); } 
  
  DateTime get createdOn => getAttribute("createdOn"); 
  void set createdOn(DateTime a) { setAttribute("createdOn", a); } 
  
  Comment newEntity() => Comment(concept); 
  Comments newEntities() => Comments(concept); 
  
} 
 
abstract class CommentsGen extends Entities<Comment> { 
 
  CommentsGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Comments newEntities() => Comments(concept); 
  Comment newEntity() => Comment(concept); 
  
} 
 
