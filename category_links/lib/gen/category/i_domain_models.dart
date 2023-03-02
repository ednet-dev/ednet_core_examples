part of category_links; 
 
// lib/gen/category/i_domain_models.dart 
 
class CategoryModels extends DomainModels { 
 
  CategoryModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from ednet_core/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(categoryLinksModelJson, domain, "Links"); 
    LinksModel linksModel = LinksModel(model); 
    add(linksModel); 
 
  } 
 
} 
 
