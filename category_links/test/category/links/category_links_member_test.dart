 
// test/category/links/category_links_member_test.dart 
 
import "package:test/test.dart"; 
import "package:ednet_core/ednet_core.dart"; 
import "package:category_links/category_links.dart"; 
 
void testCategoryLinksMembers( 
    CategoryDomain categoryDomain, LinksModel linksModel, Members members) { 
  DomainSession session; 
  group("Testing Category.Links.Member", () { 
    session = categoryDomain.newSession();  
    setUp(() { 
      linksModel.init(); 
    }); 
    tearDown(() { 
      linksModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(linksModel.isEmpty, isFalse); 
      expect(members.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      linksModel.clear(); 
      expect(linksModel.isEmpty, isTrue); 
      expect(members.isEmpty, isTrue); 
      expect(members.exceptions.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = linksModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //linksModel.displayJson(); 
      //linksModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = linksModel.toJson(); 
      linksModel.clear(); 
      expect(linksModel.isEmpty, isTrue); 
      linksModel.fromJson(json); 
      expect(linksModel.isEmpty, isFalse); 
 
      linksModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = linksModel.fromEntryToJson("Member"); 
      expect(json, isNotNull); 
 
      print(json); 
      //linksModel.displayEntryJson("Member"); 
      //linksModel.displayJson(); 
      //linksModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = linksModel.fromEntryToJson("Member"); 
      members.clear(); 
      expect(members.isEmpty, isTrue); 
      linksModel.fromJsonToEntry(json); 
      expect(members.isEmpty, isFalse); 
 
      members.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add member required error", () { 
      var memberConcept = members.concept; 
      var memberCount = members.length; 
      var member = Member(memberConcept); 
      var added = members.add(member); 
      expect(added, isFalse); 
      expect(members.length, equals(memberCount)); 
      expect(members.exceptions.length, greaterThan(0)); 
      expect(members.exceptions.toList()[0].category, equals("required")); 
 
      members.exceptions.display(title: "Add member required error"); 
    }); 
 
    test("Add member unique error", () { 
      var memberConcept = members.concept; 
      var memberCount = members.length; 
      var member = Member(memberConcept); 
      var randomMember = members.random(); 
      member.email = randomMember.email; 
      var added = members.add(member); 
      expect(added, isFalse); 
      expect(members.length, equals(memberCount)); 
      expect(members.exceptions.length, greaterThan(0)); 
 
      members.exceptions.display(title: "Add member unique error"); 
    }); 
 
    test("Not found member by oid", () { 
      var ednetOid = Oid.ts(1345648254063); 
      var member = members.singleWhereOid(ednetOid); 
      expect(member, isNull); 
    }); 
 
    test("Find member by oid", () { 
      var randomMember = members.random(); 
      var member = members.singleWhereOid(randomMember.oid); 
      expect(member, isNotNull); 
      expect(member, equals(randomMember)); 
    }); 
 
    test("Find member by attribute id", () { 
      var randomMember = members.random(); 
      var member = 
          members.singleWhereAttributeId("email", randomMember.email); 
      expect(member, isNotNull); 
      expect(member!.email, equals(randomMember.email)); 
    }); 
 
    test("Find member by required attribute", () { 
      var randomMember = members.random(); 
      var member = 
          members.firstWhereAttribute("firstName", randomMember.firstName); 
      expect(member, isNotNull); 
      expect(member.firstName, equals(randomMember.firstName)); 
    }); 
 
    test("Find member by attribute", () { 
      var randomMember = members.random(); 
      var member = 
          members.firstWhereAttribute("receiveEmail", randomMember.receiveEmail); 
      expect(member, isNotNull); 
      expect(member.receiveEmail, equals(randomMember.receiveEmail)); 
    }); 
 
    test("Select members by attribute", () { 
      var randomMember = members.random(); 
      var selectedMembers = 
          members.selectWhereAttribute("receiveEmail", randomMember.receiveEmail); 
      expect(selectedMembers.isEmpty, isFalse); 
      selectedMembers.forEach((se) => 
          expect(se.receiveEmail, equals(randomMember.receiveEmail))); 
 
      //selectedMembers.display(title: "Select members by receiveEmail"); 
    }); 
 
    test("Select members by required attribute", () { 
      var randomMember = members.random(); 
      var selectedMembers = 
          members.selectWhereAttribute("firstName", randomMember.firstName); 
      expect(selectedMembers.isEmpty, isFalse); 
      selectedMembers.forEach((se) => 
          expect(se.firstName, equals(randomMember.firstName))); 
 
      //selectedMembers.display(title: "Select members by firstName"); 
    }); 
 
    test("Select members by attribute, then add", () { 
      var randomMember = members.random(); 
      var selectedMembers = 
          members.selectWhereAttribute("firstName", randomMember.firstName); 
      expect(selectedMembers.isEmpty, isFalse); 
      expect(selectedMembers.source?.isEmpty, isFalse); 
      var membersCount = members.length; 
 
      var member = Member(members.concept); 
      member.email = 'barbara@carter.com'; 
      member.firstName = 'cloud'; 
      member.lastName = 'taxi'; 
      member.startedOn = new DateTime.now(); 
      member.receiveEmail = true; 
      member.password = 'policeman'; 
      member.role = 'energy'; 
      member.karma = 860; 
      member.about = 'restaurant'; 
      var added = selectedMembers.add(member); 
      expect(added, isTrue); 
      expect(members.length, equals(++membersCount)); 
 
      //selectedMembers.display(title: 
      //  "Select members by attribute, then add"); 
      //members.display(title: "All members"); 
    }); 
 
    test("Select members by attribute, then remove", () { 
      var randomMember = members.random(); 
      var selectedMembers = 
          members.selectWhereAttribute("firstName", randomMember.firstName); 
      expect(selectedMembers.isEmpty, isFalse); 
      expect(selectedMembers.source?.isEmpty, isFalse); 
      var membersCount = members.length; 
 
      var removed = selectedMembers.remove(randomMember); 
      expect(removed, isTrue); 
      expect(members.length, equals(--membersCount)); 
 
      randomMember.display(prefix: "removed"); 
      //selectedMembers.display(title: 
      //  "Select members by attribute, then remove"); 
      //members.display(title: "All members"); 
    }); 
 
    test("Sort members", () { 
      members.sort(); 
 
      //members.display(title: "Sort members"); 
    }); 
 
    test("Order members", () { 
      var orderedMembers = members.order(); 
      expect(orderedMembers.isEmpty, isFalse); 
      expect(orderedMembers.length, equals(members.length)); 
      expect(orderedMembers.source?.isEmpty, isFalse); 
      expect(orderedMembers.source?.length, equals(members.length)); 
      expect(orderedMembers, isNot(same(members))); 
 
      //orderedMembers.display(title: "Order members"); 
    }); 
 
    test("Copy members", () { 
      var copiedMembers = members.copy(); 
      expect(copiedMembers.isEmpty, isFalse); 
      expect(copiedMembers.length, equals(members.length)); 
      expect(copiedMembers, isNot(same(members))); 
      copiedMembers.forEach((e) => 
        expect(e, equals(members.singleWhereOid(e.oid)))); 
      copiedMembers.forEach((e) => 
        expect(e, isNot(same(members.singleWhereId(e.id!))))); 
 
      //copiedMembers.display(title: "Copy members"); 
    }); 
 
    test("True for every member", () { 
      expect(members.every((e) => e.firstName != null), isTrue); 
    }); 
 
    test("Random member", () { 
      var member1 = members.random(); 
      expect(member1, isNotNull); 
      var member2 = members.random(); 
      expect(member2, isNotNull); 
 
      //member1.display(prefix: "random1"); 
      //member2.display(prefix: "random2"); 
    }); 
 
    test("Update member id with try", () { 
      var randomMember = members.random(); 
      var beforeUpdate = randomMember.email; 
      try { 
        randomMember.email = 'carlos@hansen.com'; 
      } on UpdateException catch (e) { 
        expect(randomMember.email, equals(beforeUpdate)); 
      } 
    }); 
 
    test("Update member id without try", () { 
      var randomMember = members.random(); 
      var beforeUpdateValue = randomMember.email; 
      expect(() => randomMember.email = 'carol@phillips.com', throws); 
      expect(randomMember.email, equals(beforeUpdateValue)); 
    }); 
 
    test("Update member id with success", () { 
      var randomMember = members.random(); 
      var afterUpdateEntity = randomMember.copy(); 
      var attribute = randomMember.concept.attributes.singleWhereCode("email"); 
      expect(attribute?.update, isFalse); 
      attribute?.update = true; 
      afterUpdateEntity.email = 'bob@thomas.com'; 
      expect(afterUpdateEntity.email, equals('bob@thomas.com')); 
      attribute?.update = false; 
      var updated = members.update(randomMember, afterUpdateEntity); 
      expect(updated, isTrue); 
 
      var entity = members.singleWhereAttributeId("email", 'bob@thomas.com'); 
      expect(entity, isNotNull); 
      expect(entity!.email, equals('bob@thomas.com')); 
 
      //members.display("After update member id"); 
    }); 
 
    test("Update member non id attribute with failure", () { 
      var randomMember = members.random(); 
      var afterUpdateEntity = randomMember.copy(); 
      afterUpdateEntity.firstName = 'place'; 
      expect(afterUpdateEntity.firstName, equals('place')); 
      // members.update can only be used if oid, code or id is set. 
      expect(() => members.update(randomMember, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomMember = members.random(); 
      randomMember.display(prefix:"before copy: "); 
      var randomMemberCopy = randomMember.copy(); 
      randomMemberCopy.display(prefix:"after copy: "); 
      expect(randomMember, equals(randomMemberCopy)); 
      expect(randomMember.oid, equals(randomMemberCopy.oid)); 
      expect(randomMember.code, equals(randomMemberCopy.code)); 
      expect(randomMember.email, equals(randomMemberCopy.email)); 
      expect(randomMember.firstName, equals(randomMemberCopy.firstName)); 
      expect(randomMember.lastName, equals(randomMemberCopy.lastName)); 
      expect(randomMember.startedOn, equals(randomMemberCopy.startedOn)); 
      expect(randomMember.receiveEmail, equals(randomMemberCopy.receiveEmail)); 
      expect(randomMember.password, equals(randomMemberCopy.password)); 
      expect(randomMember.role, equals(randomMemberCopy.role)); 
      expect(randomMember.karma, equals(randomMemberCopy.karma)); 
      expect(randomMember.about, equals(randomMemberCopy.about)); 
 
      expect(randomMember.id, isNotNull); 
      expect(randomMemberCopy.id, isNotNull); 
      expect(randomMember.id, equals(randomMemberCopy.id)); 
 
      var idsEqual = false; 
      if (randomMember.id == randomMemberCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomMember.id!.equals(randomMemberCopy.id!)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("member action undo and redo", () { 
      var memberCount = members.length; 
      var member = Member(members.concept); 
        member.email = 'andrew@hughes.com'; 
      member.firstName = 'music'; 
      member.lastName = 'flower'; 
      member.startedOn = new DateTime.now(); 
      member.receiveEmail = true; 
      member.password = 'interest'; 
      member.role = 'web'; 
      member.karma = 106.54141273264428; 
      member.about = 'cable'; 
      members.add(member); 
      expect(members.length, equals(++memberCount)); 
      members.remove(member); 
      expect(members.length, equals(--memberCount)); 
 
      var action = AddCommand(session, members, member); 
      action.doIt(); 
      expect(members.length, equals(++memberCount)); 
 
      action.undo(); 
      expect(members.length, equals(--memberCount)); 
 
      action.redo(); 
      expect(members.length, equals(++memberCount)); 
    }); 
 
    test("member session undo and redo", () { 
      var memberCount = members.length; 
      var member = Member(members.concept); 
        member.email = 'bob@nguyen.com'; 
      member.firstName = 'house'; 
      member.lastName = 'mind'; 
      member.startedOn = new DateTime.now(); 
      member.receiveEmail = true; 
      member.password = 'teaching'; 
      member.role = 'lifespan'; 
      member.karma = 622; 
      member.about = 'knowledge'; 
      members.add(member); 
      expect(members.length, equals(++memberCount)); 
      members.remove(member); 
      expect(members.length, equals(--memberCount)); 
 
      var action = AddCommand(session, members, member); 
      action.doIt(); 
      expect(members.length, equals(++memberCount)); 
 
      session.past.undo(); 
      expect(members.length, equals(--memberCount)); 
 
      session.past.redo(); 
      expect(members.length, equals(++memberCount)); 
    }); 
 
    test("Member update undo and redo", () { 
      var member = members.random(); 
      var action = SetAttributeCommand(session, member, "firstName", 'craving'); 
      action.doIt(); 
 
      session.past.undo(); 
      expect(member.firstName, equals(action.before)); 
 
      session.past.redo(); 
      expect(member.firstName, equals(action.after)); 
    }); 
 
    test("Member action with multiple undos and redos", () { 
      var memberCount = members.length; 
      var member1 = members.random(); 
 
      var action1 = RemoveCommand(session, members, member1); 
      action1.doIt(); 
      expect(members.length, equals(--memberCount)); 
 
      var member2 = members.random(); 
 
      var action2 = RemoveCommand(session, members, member2); 
      action2.doIt(); 
      expect(members.length, equals(--memberCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(members.length, equals(++memberCount)); 
 
      session.past.undo(); 
      expect(members.length, equals(++memberCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(members.length, equals(--memberCount)); 
 
      session.past.redo(); 
      expect(members.length, equals(--memberCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var memberCount = members.length; 
      var member1 = members.random(); 
      var member2 = members.random(); 
      while (member1 == member2) { 
        member2 = members.random();  
      } 
      var action1 = RemoveCommand(session, members, member1); 
      var action2 = RemoveCommand(session, members, member2); 
 
      var transaction = new Transaction("two removes on members", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doIt(); 
      memberCount = memberCount - 2; 
      expect(members.length, equals(memberCount)); 
 
      members.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      memberCount = memberCount + 2; 
      expect(members.length, equals(memberCount)); 
 
      members.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      memberCount = memberCount - 2; 
      expect(members.length, equals(memberCount)); 
 
      members.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var memberCount = members.length; 
      var member1 = members.random(); 
      var member2 = member1; 
      var action1 = RemoveCommand(session, members, member1); 
      var action2 = RemoveCommand(session, members, member2); 
 
      var transaction = Transaction( 
        "two removes on members, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doIt(); 
      expect(done, isFalse); 
      expect(members.length, equals(memberCount)); 
 
      //members.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to member actions", () { 
      var memberCount = members.length; 
 
      var reaction = MemberReaction(); 
      expect(reaction, isNotNull); 
 
      categoryDomain.startCommandReaction(reaction); 
      var member = Member(members.concept); 
        member.email = 'patricia@chen.com'; 
      member.firstName = 'brave'; 
      member.lastName = 'pencil'; 
      member.startedOn = new DateTime.now(); 
      member.receiveEmail = true; 
      member.password = 'policeman'; 
      member.role = 'message'; 
      member.karma = 866; 
      member.about = 'yellow'; 
      members.add(member); 
      expect(members.length, equals(++memberCount)); 
      members.remove(member); 
      expect(members.length, equals(--memberCount)); 
 
      var session = categoryDomain.newSession(); 
      var addCommand = AddCommand(session, members, member); 
      addCommand.doIt(); 
      expect(members.length, equals(++memberCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeCommand = SetAttributeCommand( 
        session, member, "firstName", 'beginning'); 
      setAttributeCommand.doIt(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      categoryDomain.cancelCommandReaction(reaction); 
    }); 
 
  }); 
} 
 
class MemberReaction implements ICommandReaction { 
  bool reactedOnAdd    = false; 
  bool reactedOnUpdate = false; 
 
  void react(ICommand action) { 
    if (action is IEntitiesCommand) { 
      reactedOnAdd = true; 
    } else if (action is IEntityCommand) { 
      reactedOnUpdate = true; 
    } 
  } 
} 
 
void main() { 
  var repository = Repository(); 
  CategoryDomain categoryDomain = repository.getDomainModels("Category") as CategoryDomain;   
  assert(categoryDomain != null); 
  LinksModel linksModel = categoryDomain.getModelEntries("Links") as LinksModel;  
  assert(linksModel != null); 
  var members = linksModel.members; 
  testCategoryLinksMembers(categoryDomain, linksModel, members); 
} 
 
