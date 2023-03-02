part of category_links; 
 
// lib/gen/category/links/interests.dart 
 
abstract class InterestGen extends Entity<Interest> { 
 
  InterestGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Reference get categoryReference => getReference("category") as Reference; 
  void set categoryReference(Reference reference) { setReference("category", reference); } 
  
  Category get category => getParent("category") as Category; 
  void set category(Category p) { setParent("category", p); } 
  
  Reference get memberReference => getReference("member") as Reference; 
  void set memberReference(Reference reference) { setReference("member", reference); } 
  
  Member get member => getParent("member") as Member; 
  void set member(Member p) { setParent("member", p); } 
  
  String get description => getAttribute("description"); 
  void set description(String a) { setAttribute("description", a); } 
  
  Interest newEntity() => Interest(concept); 
  Interests newEntities() => Interests(concept); 
  
} 
 
abstract class InterestsGen extends Entities<Interest> { 
 
  InterestsGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Interests newEntities() => Interests(concept); 
  Interest newEntity() => Interest(concept); 
  
} 
 
