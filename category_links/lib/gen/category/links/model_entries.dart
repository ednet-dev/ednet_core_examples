part of category_links; 
 
// lib/gen/category/links/model_entries.dart 
 
class LinksEntries extends ModelEntries { 
 
  LinksEntries(Model model) : super(model); 
 
  Map<String, Entities> newEntries() { 
    var entries = Map<String, Entities>(); 
    var concept; 
    concept = model.concepts.singleWhereCode("Member"); 
    entries["Member"] = Members(concept); 
    concept = model.concepts.singleWhereCode("Category"); 
    entries["Category"] = Categories(concept); 
    concept = model.concepts.singleWhereCode("Comment"); 
    entries["Comment"] = Comments(concept); 
    concept = model.concepts.singleWhereCode("Question"); 
    entries["Question"] = Questions(concept); 
    return entries; 
  } 
 
  Entities? newEntities(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Member") { 
      return Members(concept); 
    } 
    if (concept.code == "Category") { 
      return Categories(concept); 
    } 
    if (concept.code == "WebLink") { 
      return WebLinks(concept); 
    } 
    if (concept.code == "Interest") { 
      return Interests(concept); 
    } 
    if (concept.code == "Comment") { 
      return Comments(concept); 
    } 
    if (concept.code == "Question") { 
      return Questions(concept); 
    } 
    return null; 
  } 
 
  Entity? newEntity(String conceptCode) { 
    var concept = model.concepts.singleWhereCode(conceptCode); 
    if (concept == null) { 
      throw ConceptError("${conceptCode} concept does not exist.") ; 
    } 
    if (concept.code == "Member") { 
      return Member(concept); 
    } 
    if (concept.code == "Category") { 
      return Category(concept); 
    } 
    if (concept.code == "WebLink") { 
      return WebLink(concept); 
    } 
    if (concept.code == "Interest") { 
      return Interest(concept); 
    } 
    if (concept.code == "Comment") { 
      return Comment(concept); 
    } 
    if (concept.code == "Question") { 
      return Question(concept); 
    } 
    return null; 
  } 
 
  Members get members => getEntry("Member") as Members; 
  Categories get categories => getEntry("Category") as Categories; 
  Comments get comments => getEntry("Comment") as Comments; 
  Questions get questions => getEntry("Question") as Questions; 
 
} 
 
