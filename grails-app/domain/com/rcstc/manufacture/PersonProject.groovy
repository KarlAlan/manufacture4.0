package com.rcstc.manufacture

import org.apache.commons.lang.builder.HashCodeBuilder

class PersonProject implements Serializable {

    private static final long serialVersionUID = 1

    Person person
    Project project
    ProjectRole projectRole

    boolean equals(other) {
        if (!(other instanceof PersonProject)) {
            return false
        }

        other.person?.id == person?.id &&
                other.project?.id == project?.id &&
                    other.projectRole?.id == projectRole?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (person) builder.append(person.id)
        if (project) builder.append(project.id)
        if (projectRole) builder.append(projectRole.id)
        builder.toHashCode()
    }

    static PersonProject get(long personId, long projectId, ProjectRole pr) {
        PersonProject.where {
            person == Person.load(personId) &&
                    project == Project.load(projectId) &&
                        projectRole == pr.id
        }.get()
    }

    static boolean exists(long personId, long projectId, ProjectRole pr) {
        PersonProject.where {
            person == Person.load(personId) &&
                    project == Project.load(projectId) &&
                    projectRole == pr.id
        }.count() > 0
    }

    static PersonProject create(Person person, Project project, ProjectRole pr, boolean flush = false) {
        def instance = new PersonProject(person: person, project: project, projectRole: pr)
        instance.save(flush: flush, insert: true)
        instance
    }

    static boolean remove(Person person, Project project, ProjectRole pr, boolean flush = false) {
        if (person == null || project == null) return false

        int rowCount = PersonProject.where {
            person == Person.load(person.id) &&
                    project == Project.load(project.id) &&
                    projectRole == pr
        }.deleteAll()

        if (flush) { PersonProject.withSession { it.flush() } }

        rowCount > 0
    }

    static void removeAll(Person p, boolean flush = false) {
        if (p == null) return

        PersonProject.where {
            person == Person.load(p.id)
        }.deleteAll()

        if (flush) { PersonProject.withSession { it.flush() } }
    }

    static void removeAll(Project p, boolean flush = false) {
        if (p == null) return

        PersonProject.where {
            project == Project.load(p.id)
        }.deleteAll()

        if (flush) { PersonProject.withSession { it.flush() } }
    }

    static constraints = {
        /*
        role validator: { Role r, UserRole ur ->
            if (ur.user == null) return
            boolean existing = false
            UserRole.withNewSession {
                existing = UserRole.exists(ur.user.id, r.id)
            }
            if (existing) {
                return 'userRole.exists'
            }
        }
        */
    }

    static mapping = {
        id composite: ['person', 'project', 'projectRole']
        version false
    }
}

public enum ProjectRole {
    项目领导小组成员('10'),
    IT部负责人('11'),
    运营部负责人('12'),
    业务负责人('13'),
    项目经理('20'),
    业务人员('30'),
    关键用户('40'),
    需求分析师('42'),
    系统设计师('45'),
    架构师('48'),
    开发人员('50'),
    测试人员('60'),
    DBA('80'),
    其他('90')

    String id

    ProjectRole(String id) { this.id = id }
}