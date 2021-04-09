<template>

  <div class="account">
    
    <h1>Welcome Back nya!</h1>
    <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src='../Assets/CatUsers/1015.jpg' />
  <add-cat></add-cat>
    
      <button id="delete"  v-on:click="deleteProfile">Delete Account</button>
   
  </div>
  

</template>

<script>

import AddCat from '../components/AddCat.vue';
import catService from '../services/CatService.js';

export default {
  name: "account",
  components: {
    AddCat
  },
  methods:{
    deleteProfile() {
      if (confirm("Are you sure you want to delete? This action cannot be undone."))
      {catService
        .deleteCat(this.catId)
        .then((response) => {
          console.log(response.status);
          if (response.status == "201") {

              alert("Account successfully deleted");
              this.$store.commit("DELETE_CAT", this.catId);
            //success
            this.$router.push("/");
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error);
        });
      }
    }
  },
// created() {
//     const catId = this.$route.params.id;
//     this.$store.commit("DELETE_CAT", catId);
//   },
}
</script>

<style scoped>
.water-cat {
  height: 50%;
  width: 50%;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.home {
  text-align: center;
}

#delete {
  font-size: .5em;

}

/* * {
  background-image: url("../Assets/CatUsers/1015.jpg");
  background-position: center center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
} */
</style>