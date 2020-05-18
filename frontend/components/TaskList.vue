<template>
  <v-container fluid grid-list-lg class="card-body">
    <v-layout row wrap>
      <v-flex v-for="task in tasks" :key="task.id" xs12>
        <task-item :tasks="tasks" :task="task" :content-rule="contentRule" />
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import TaskItem from './TaskItem'

export default {
  components: { TaskItem },
  props: {
    tasks: Array,
    contentRule: Array
  }
}
</script>

<style>
.card-body {
  max-height: 500px;
  min-height: 0;
  overflow: auto;
  display: block;
}

.card-body::-webkit-scrollbar {
  width: 10px;
	background-color: #F5F5F5;
}

.card-body::-webkit-scrollbar-track {
  border-radius: 10px;
  background: rgba(0,0,0,0.1);
  border: 1px solid #ccc;
}

.card-body::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: linear-gradient(to left, #fff, #e4e4e4);
  border: 1px solid #aaa;
}

.card-body::-webkit-scrollbar-thumb:hover {
  background: #fff;
}

.card-body::-webkit-scrollbar-thumb:active {
  background: linear-gradient(to left, #22ADD4, #1E98BA);
}
</style>
