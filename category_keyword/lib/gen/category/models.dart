part of category_keyword; 
 
// lib/gen/category/i_domain_models.dart
 
class CategoryModels extends DomainModels { 
 
  CategoryModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from ednet_core/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(categoryKeywordModelJson, domain, "Keyword"); 
    KeywordModel keywordModel = new KeywordModel(model); 
    add(keywordModel); 
 
  } 
 
} 
 
