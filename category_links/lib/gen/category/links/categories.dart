part of category_links; 
 
// lib/gen/category/links/categories.dart 
 
abstract class CategoryGen extends Entity<Category> { 
 
  CategoryGen(Concept concept) { 
    this.concept = concept; 
    Concept? webLinkConcept = concept.model.concepts.singleWhereCode("WebLink"); 
    assert(webLinkConcept!= null); 
    setChild("webLinks", WebLinks(webLinkConcept!)); 
    Concept? interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    assert(interestConcept!= null); 
    setChild("interests", Interests(interestConcept!)); 
    Concept? questionConcept = concept.model.concepts.singleWhereCode("Question"); 
    assert(questionConcept!= null); 
    setChild("questions", Questions(questionConcept!)); 
  } 
 
  String get name => getAttribute("name"); 
  void set name(String a) { setAttribute("name", a); } 
  
  String get description => getAttribute("description"); 
  void set description(String a) { setAttribute("description", a); } 
  
  bool get approved => getAttribute("approved"); 
  void set approved(bool a) { setAttribute("approved", a); } 
  
  WebLinks get webLinks => getChild("webLinks") as WebLinks; 
  
  Interests get interests => getChild("interests") as Interests; 
  
  Questions get questions => getChild("questions") as Questions; 
  
  Category newEntity() => Category(concept); 
  Categories newEntities() => Categories(concept); 
  
} 
 
abstract class CategoriesGen extends Entities<Category> { 
 
  CategoriesGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Categories newEntities() => Categories(concept); 
  Category newEntity() => Category(concept); 
  
} 
 
