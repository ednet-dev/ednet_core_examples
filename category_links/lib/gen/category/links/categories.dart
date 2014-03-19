part of category_links; 
 
// lib/gen/category/links/categories.dart 
 
abstract class CategoryGen extends ConceptEntity<Category> { 
 
  CategoryGen(Concept concept) : super.of(concept) { 
    Concept webLinkConcept = concept.model.concepts.singleWhereCode("WebLink"); 
    setChild("webLinks", new WebLinks(webLinkConcept)); 
    Concept interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    setChild("interests", new Interests(interestConcept)); 
    Concept questionConcept = concept.model.concepts.singleWhereCode("Question"); 
    setChild("questions", new Questions(questionConcept)); 
  } 
 
  CategoryGen.withId(Concept concept, String name) : super.of(concept) { 
    setAttribute("name", name); 
    Concept webLinkConcept = concept.model.concepts.singleWhereCode("WebLink"); 
    setChild("webLinks", new WebLinks(webLinkConcept)); 
    Concept interestConcept = concept.model.concepts.singleWhereCode("Interest"); 
    setChild("interests", new Interests(interestConcept)); 
    Concept questionConcept = concept.model.concepts.singleWhereCode("Question"); 
    setChild("questions", new Questions(questionConcept)); 
  } 
 
  String get name => getAttribute("name"); 
  set name(String a) => setAttribute("name", a); 
  
  String get description => getAttribute("description"); 
  set description(String a) => setAttribute("description", a); 
  
  bool get approved => getAttribute("approved"); 
  set approved(bool a) => setAttribute("approved", a); 
  
  WebLinks get webLinks => getChild("webLinks"); 
  
  Interests get interests => getChild("interests"); 
  
  Questions get questions => getChild("questions"); 
  
  Category newEntity() => new Category(concept); 
  Categories newEntities() => new Categories(concept); 
  
  int nameCompareTo(Category other) { 
    return name.compareTo(other.name); 
  } 
 
} 
 
abstract class CategoriesGen extends Entities<Category> { 
 
  CategoriesGen(Concept concept) : super.of(concept); 
 
  Categories newEntities() => new Categories(concept); 
  Category newEntity() => new Category(concept); 
  
} 
 
