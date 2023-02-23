part of default_project; 
 
// lib/gen/default/models.dart 
 
class DefaultModels extends DomainModels { 
 
  DefaultModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from ednet_core/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(defaultProjectModelJson, domain, "Project"); 
    ProjectModel projectModel = new ProjectModel(model); 
    add(projectModel); 
 
  } 
 
} 
 
