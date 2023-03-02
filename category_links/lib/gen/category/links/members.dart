part of category_links; 
 
// lib/gen/category/links/members.dart 
 
abstract class MemberGen extends Entity<Member> { 
 
  MemberGen(Concept concept) { 
    this.concept = concept; 
    Concept? interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    assert(interestConcept!= null); 
    setChild("interests", Interests(interestConcept!)); 
  } 
 
  String get email => getAttribute("email"); 
  void set email(String a) { setAttribute("email", a); } 
  
  String get firstName => getAttribute("firstName"); 
  void set firstName(String a) { setAttribute("firstName", a); } 
  
  String get lastName => getAttribute("lastName"); 
  void set lastName(String a) { setAttribute("lastName", a); } 
  
  DateTime get startedOn => getAttribute("startedOn"); 
  void set startedOn(DateTime a) { setAttribute("startedOn", a); } 
  
  bool get receiveEmail => getAttribute("receiveEmail"); 
  void set receiveEmail(bool a) { setAttribute("receiveEmail", a); } 
  
  String get password => getAttribute("password"); 
  void set password(String a) { setAttribute("password", a); } 
  
  String get role => getAttribute("role"); 
  void set role(String a) { setAttribute("role", a); } 
  
  num get karma => getAttribute("karma"); 
  void set karma(num a) { setAttribute("karma", a); } 
  
  String get about => getAttribute("about"); 
  void set about(String a) { setAttribute("about", a); } 
  
  Interests get interests => getChild("interests") as Interests; 
  
  Member newEntity() => Member(concept); 
  Members newEntities() => Members(concept); 
  
} 
 
abstract class MembersGen extends Entities<Member> { 
 
  MembersGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Members newEntities() => Members(concept); 
  Member newEntity() => Member(concept); 
  
} 
 
