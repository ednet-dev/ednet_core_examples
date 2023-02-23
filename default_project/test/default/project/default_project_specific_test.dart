 
// test/default/project/default_project_project_test.dart 
 
import "package:test/test.dart"; 
import "package:ednet_core/ednet_core.dart"; 
import "package:default_project/default_project.dart"; 

class ProjectReaction implements ActionReactionApi {
  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  react(BasicAction action) {
    if (action is EntitiesAction) {
      reactedOnAdd = true;
    } else if (action is EntityAction) {
      reactedOnUpdate = true;
    }
  }
}
 
testDefaultProjectProject( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var session; 
  var model; 
  var projects; 
  group("Testing Default.Project.Project", () { 
    domain = repository.getDomainModels(domainCode); 
    session = domain.newSession(); 
    model = domain.getModelEntries(modelCode); 
    //expect(model, isNotNull); 
    projects = model.projects; 
    //expect(projects.isEmpty, isTrue); 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    });  
    
    test('From model to JSON', () {
      var json = model.toJson();
      expect(json, isNotNull);

      print(json);
      //model.displayJson(); 
      //model.display();
    });
    
    test('From JSON to model', () {
      var json = model.toJson();
      model.clear();
      expect(model.isEmpty, isTrue);
      model.fromJson(json);
      expect(model.isEmpty, isFalse);

      model.display();
    });
    
    test('Add project required error', () {
      var projectConcept = projects.concept;
      var projectCount = projects.length;
      var project = new Project(projectConcept);
      expect(project, isNotNull);
      var added = projects.add(project);
      expect(added, isFalse);
      expect(projects.length, equals(projectCount));
      expect(projects.errors.length, equals(1));
      expect(projects.errors.toList()[0].category, equals('required'));

      projects.errors.display(title:'Add project required error');
    });
 
    test('Add project pre validation error', () {
      var projectConcept = projects.concept;
      var projectCount = projects.length;
      var project = new Project(projectConcept);
      expect(project, isNotNull);
      project.name =
          'A new project with a long name that cannot be accepted';
      var added = projects.add(project);
      expect(added, isFalse);
      expect(projects.length, equals(projectCount));
      expect(projects.errors, hasLength(1));
      expect(projects.errors.toList()[0].category, equals('pre'));

      projects.errors.display(title:'Add project pre validation error');
    }); 
    
    test('Not found project by new oid', () {
      var dartlingOid = new Oid.ts(1345648254063);
      var project = projects.singleWhereOid(dartlingOid);
      expect(project, isNull);
    });
    
    test('Find project by oid', () {
      var randomProject = projects.random();
      var project = projects.singleWhereOid(randomProject.oid);
      expect(project, isNotNull);
      expect(project, equals(randomProject));
    });
    
    test('Find project by id', () {
      var projectConcept = projects.concept;
      Id id = new Id(projectConcept);
      expect(id.length, equals(1));
      var randomProject = projects.random();
      var randomName = randomProject.name;
      id.setAttribute('name', randomName);
      var project = projects.singleWhereId(id);
      expect(project, isNotNull);
      expect(project.name, equals(randomName));
    });
    
    test('Find project by attribute id', () {
      var randomProject = projects.random();
      var randomName = randomProject.name;
      var project = projects.singleWhereAttributeId('name', randomName);
      expect(project, isNotNull);
      expect(project.name, equals(randomName));
    });
    
    test('Find project by attribute', () {
      var randomProject = projects.random();
      var randomDescription = randomProject.description;
      var project = 
          projects.firstWhereAttribute('description', randomDescription);
      expect(project, isNotNull);
      expect(project.description, equals(randomDescription));
    });
    
    test('Find project by specific method', () {
      var randomProject = projects.random();
      var randomName = randomProject.name;
      var project = projects.findByNameId(randomName);
      expect(project, isNotNull);
      expect(project.name, equals(randomName));
    });
    
    test('Select projects by attribute', () {
      var randomProject = projects.random();
      var randomDescription = randomProject.description;
      var selectedProjects = 
          projects.selectWhereAttribute('description', randomDescription);
      expect(selectedProjects.isEmpty, isFalse);
      selectedProjects.forEach((se) => 
          expect(se.description, equals(randomDescription)));
    });
    
    test('Select projects by specific property', () {
      var randomProject = projects.random();
      randomProject.description = "Dart programming blog.";
      var programmingProjects = projects.selectWhere((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);
      //expect(programmingProjects.length, equals(1));

      programmingProjects.display(title:'Select projects by specific property');
    });
    
    test('Select projects then add', () {
      var randomProject = projects.random();
      randomProject.description = "Dart programming blog.";
      var programmingProjects = projects.selectWhere((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);
      expect(programmingProjects.source.isEmpty, isFalse);
      var projectsCount = projects.length;  

      var projectConcept = projects.concept;
      var programmingProject = new Project(projectConcept);
      programmingProject.name = 'dartling Testing';
      programmingProject.description = 'Programming unit tests.';
      var added = programmingProjects.add(programmingProject);
      expect(added, isTrue);     
      expect(projects.length, equals(++projectsCount));

      programmingProjects.display(title:'Select projects then add');
      projects.display(title:'All projects');
    });
    
    test('Select projects then remove', () {
      var projectCount = projects.length;
      var randomProject = projects.random();
      randomProject.description = "Dart programming blog.";
      //projects.display('Projects before remove');

      Projects programmingProjects = projects.selectWhere((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);
      expect(programmingProjects.source.isEmpty, isFalse);

      var randomName = randomProject.name;
      var project = programmingProjects.findByNameId(randomName);
      expect(project, isNotNull);
      expect(project.name, equals(randomName));
      var programmingProjectCount = programmingProjects.length;
      programmingProjects.remove(project);
      expect(programmingProjects.length, equals(--programmingProjectCount));
      expect(projects.length, equals(--projectCount));
    });
 
    test("Order projects by id", () { 
      var orderedProjects = projects.order(); 
      expect(orderedProjects.isEmpty, isFalse); 
      expect(orderedProjects.length, equals(projects.length)); 
      expect(orderedProjects.source.isEmpty, isFalse); 
      expect(orderedProjects.source.length, equals(projects.length));
      expect(orderedProjects, isNot(same(projects))); 
 
      //orderedProjects.display(title: "Order projects by id"); 
    });
    
    test('New project with id', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      var added = projects.add(marketing);
      expect(added, isTrue);
      expect(projects.length, equals(++projectCount));

      projects.display(title:'New project with id');
    });

    test('Update project id with try', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.length, equals(++projectCount));

      var beforeNameUpdate = marketing.name;
      try {
        marketing.name = 'Marketing dartling';
      } on UpdateError catch (e) {
        expect(marketing.name, equals(beforeNameUpdate));
      }
    });

    test('Update project id without try', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.length, equals(++projectCount));

      var beforeNameUpdate = marketing.name;
      expect(() => marketing.name = 'Marketing dartling', throws);
      expect(marketing.name, equals(beforeNameUpdate));
    });
    
    test('Update project id with success', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.length, equals(++projectCount));

      //projects.display('Before update project id with success');

      var afterUpdateMarketing = marketing.copy();
      var nameAttribute = marketing.concept.attributes.singleWhereCode('name');
      expect(nameAttribute.update, isFalse);
      nameAttribute.update = true;
      var newName = 'Marketing dartling';
      afterUpdateMarketing.name = newName;
      expect(afterUpdateMarketing.name, equals(newName));
      nameAttribute.update = false;
      var updated = projects.update(marketing, afterUpdateMarketing);
      expect(updated, isTrue);

      //projects.display('After update project id with success');

      var marketingDartling = projects.singleWhereAttributeId('name', newName);
      expect(marketingDartling, isNotNull);
      expect(marketingDartling.name, equals(newName));
    });
    
    test('Update project description with failure', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.length, equals(++projectCount));

      var beforeDescriptionUpdate = marketing.description;
      var afterUpdateMarketing = marketing.copy();
      var newDescription = 'Writing papers about dartling';
      afterUpdateMarketing.description = newDescription;
      expect(afterUpdateMarketing.description, equals(newDescription));
      // Projects.update can only be used if oid, code or id set.
      expect(() => projects.update(marketing, afterUpdateMarketing), throws);
    });
    
    test('Copy Equality', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';
      projects.add(marketing);
      expect(projects.length, equals(++projectCount));

      marketing.display(prefix:'before copy: ');
      var marketingCopy = marketing.copy();
      marketingCopy.display(prefix:'after copy: ');
      expect(marketing, equals(marketingCopy));
      expect(marketing.oid, equals(marketingCopy.oid));
      expect(marketing.code, equals(marketingCopy.code));
      expect(marketing.name, equals(marketingCopy.name));
      expect(marketing.description, equals(marketingCopy.description));

      expect(marketing.id, isNotNull);
      expect(marketingCopy.id, isNotNull);
      expect(marketing.id, equals(marketingCopy.id));

      var idsEqual = false;
      if (marketing.id == marketingCopy.id) {
        idsEqual = true;
      }
      expect(idsEqual, isTrue);

      idsEqual = false;
      if (marketing.id.equals(marketingCopy.id)) {
        idsEqual = true;
      }
      expect(idsEqual, isTrue);
    });
    
    test('New project undo and redo', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';

      var action = new AddAction(session, projects, marketing);
      action.doit();
      expect(projects.length, equals(++projectCount));

      action.undo();
      expect(projects.length, equals(--projectCount));

      action.redo();
      expect(projects.length, equals(++projectCount));
    });
    
    test('New project undo and redo with session', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;
      var marketing = new Project.withId(projectConcept, 'dartling Marketing');
      expect(marketing, isNotNull);
      marketing.description = 'Making dartling known to the Dart community.';

      var action = new AddAction(session, projects, marketing);
      action.doit();
      expect(projects.length, equals(++projectCount));

      session.past.undo();
      expect(projects.length, equals(--projectCount));

      session.past.redo();
      expect(projects.length, equals(++projectCount));
    });
    
    test('Undo and redo update project', () {
      var randomProject = projects.random();
      var randomName = randomProject.name;
      var project = projects.singleWhereAttributeId('name', randomName);
      expect(project, isNotNull);
      expect(project.name, equals(randomName));

      var action = new SetAttributeAction(session, project, 'description',
          'Domain Model Framework.');
      action.doit();

      session.past.undo();
      expect(project.description, equals(action.before));

      session.past.redo();
      expect(project.description, equals(action.after));
    });
    
    test('Project action with multiple undos and redos ', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';

      var action1 = new AddAction(session, projects, project1);
      action1.doit();
      expect(projects.length, equals(++projectCount));

      var project2 = new Project(projectConcept);
      project2.name = 'Database design';

      var action2 = new AddAction(session, projects, project2);
      action2.doit();
      expect(projects.length, equals(++projectCount));

      //session.past.display();

      session.past.undo();
      expect(projects.length, equals(--projectCount));

      session.past.undo();
      expect(projects.length, equals(--projectCount));

      //session.past.display();

      session.past.redo();
      expect(projects.length, equals(++projectCount));

      session.past.redo();
      expect(projects.length, equals(++projectCount));

      //session.past.display();
    });
    
    test('Undo and redo transaction', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';
      var action1 = new AddAction(session, projects, project1);

      var project2 = new Project(projectConcept);
      project2.name = 'Database design';
      var action2 = new AddAction(session, projects, project2);

      var transaction = new Transaction('two adds on projects', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doit();
      projectCount = projectCount + 2;
      expect(projects.length, equals(projectCount));

      projects.display(title:'Transaction Done');

      session.past.undo();
      projectCount = projectCount - 2;
      expect(projects.length, equals(projectCount));

      projects.display(title:'Transaction Undone');

      session.past.redo();
      projectCount = projectCount + 2;
      expect(projects.length, equals(projectCount));

      projects.display(title:'Transaction Redone');
    });
    
    test('Transaction with id error', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;

      var project1 = new Project(projectConcept);
      project1.name = 'Data modeling';
      var action1 = new AddAction(session, projects, project1);

      var project2 = new Project(projectConcept);
      //project2.name = 'Database design';
      var action2 = new AddAction(session, projects, project2);

      var transaction = new Transaction(
        'two adds on projects, with an error on the second', session);
      transaction.add(action1);
      transaction.add(action2);
      var done = transaction.doit();
      expect(done, isFalse);
      expect(projects.length, equals(projectCount));

      projects.display(title:'Transaction with id error');
    });
    
    test('Reactions to project actions', () {
      var projectCount = projects.length;
      var projectConcept = projects.concept;

      var reaction = new ProjectReaction();
      expect(reaction, isNotNull);

      domain.startActionReaction(reaction);
      var project = new Project(projectConcept);
      project.name = 'dartling Documentation';

      var session = domain.newSession();
      var addAction = new AddAction(session, projects, project);
      addAction.doit();
      expect(projects.length, equals(++projectCount));
      expect(reaction.reactedOnAdd, isTrue);

      var description = 'Documenting dartling.';
      var setAttributeAction =
          new SetAttributeAction(session, project, 'description', description);
      setAttributeAction.doit();
      expect(reaction.reactedOnUpdate, isTrue);
      domain.cancelActionReaction(reaction);
    });
    
  }); 
} 
 
void main() { 
  testDefaultProjectProject(new Repository(), "Default", "Project"); 
} 
 
