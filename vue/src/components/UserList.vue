<template>
  <div>
    <a href="#">List of Cat Users</a>
    <user-display
    v-for="cat in filteredCats"
    v-bind:key="cat.name"
    v-bind:user="user"
    />
  </div>
</template>

<script>
import UserDisplay from '@/components/UserDisplay.vue'


export default {
  name: "user-list",
  components: {
    UserDisplay
    
  
  },

  data() {
    return {
      occupationFilter: "",
    };
  },
  computed: {
    filteredCats() {
      const filteredCats = this.$store.state.catlist;
      console.log(filteredCats);
      return filteredCats.filter((user) => {
        return this.occupationFilter === ""
          ? true
          : this.occupationFilter === user.occupation;
      });
    },
  },
};
</script>

<style>




</style>