<template>
  <v-layout align-center justify-center>
    <v-flex xs12 sm8 md4 class="todo-card">
      <v-card class="elevation-12 custom-card">
        <task-create-form :content-rule="contentRule" />
        <task-list :tasks="taskList" :content-rule="contentRule" />
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import TaskList from './TaskList'
import TaskCreateForm from './TaskCreateForm'

export default {
  components: { TaskList, TaskCreateForm },
  data() {
    return {
      error: null,
      content: "",
      contentRule: [v => !!v || "Content is required"]
    }
  },
  props: {
    taskList: Array
  }
}
</script>

<style>
.todo-card {
  max-height: calc(100vh - 200px);
  border: 1px solid #c2c2c2;
  border-radius: 10px;
  z-index: 1;
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}

.todo-card:hover, .todo-card:focus {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}

.custom-card {
  border-radius: 10px;
}
</style>
