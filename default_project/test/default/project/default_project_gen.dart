 
// test/default/project/default_project_gen.dart 
 
import "package:default_project/default_project.dart"; 
 
genCode(CoreRepository repository) { 
  repository.gen("default_project"); 
} 
 
initData(CoreRepository repository) { 
   var defaultDomain = repository.getDomainModels("Default"); 
   var projectModel = defaultDomain.getModelEntries("Project"); 
   projectModel.init(); 
   //projectModel.display(); 
} 
 
void main() { 
  var repository = CoreRepository(); 
  genCode(repository); 
  //initData(repository); 
} 
 
