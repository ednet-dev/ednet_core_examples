 
// web/default/project/default_project_web.dart 
 
import "dart:html"; 
 
import "package:ednet_core_default_app/ednet_core_default_app.dart"; 
import "package:default_project/default_project.dart"; 
 
initData(CoreRepository repository) { 
   var defaultDomain = repository.getDomainModels("Default"); 
   var projectModel = defaultDomain.getModelEntries("Project"); 
   projectModel.init(); 
   //projectModel.display(); 
} 
 
showData(CoreRepository repository) { 
   var mainView = new View(document, "main"); 
   mainView.repo = repository; 
   new RepoMainSection(mainView); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  initData(repository); 
  showData(repository); 
} 
 
