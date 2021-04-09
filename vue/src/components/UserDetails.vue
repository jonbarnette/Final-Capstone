<template>
  <div id="userdetail">
  
    <div class="placeFrequented">
      <h3>List Of Places Frequented</h3>

      <p>Places placeholder</p>
    </div>
  <div class="summaryDetail">
      <h3>Cat Summary</h3>
    </div>
    <div id="userBio" v-for="cat in catsArray" v-bind:key="cat.catId">
       <div>Name:{{ cat.name }}</div> 

      <div>Lives</div>
      <div>Occupation</div>
      <div>Breed</div>
      <div>Color</div>
    </div>  
    
  </div>
</template>

<script>
import catService from "@/services/CatService.js";

export default {
  name: "user-details",

  data() {
    return {
      catsArray: [],
    };
  },

  methods: {
    viewCatDetails() {
      this.$router.push("/catdetails");
    },
    
  },
  created() {
      const catId = this.$store.state.catId;
      
      catService.getCatDetails(catId).then((response) => {
        console.log(response)
        console.log(response.data)
        
        this.catsArray = response.data;
      }).catch(error =>{
        console.log(error.statusMsg)
      });
    },
};
</script>



<style>


.image {
  display: block;
  width: 100%;
  height: auto;
}

</style>