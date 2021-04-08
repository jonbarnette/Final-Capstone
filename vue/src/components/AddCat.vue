<template>
  <div id="addCatform">
    <form v-on:submit.prevent="submitForm" class="catForm">
      <div class="form-group">
        <label for="catName"> Name:</label>
        <input
          id="catName"
          type="text"
          class="form-control"
          v-model="cat.name"
          required
        />
      </div>
      <div class="form-group">
        <label for="breed">Breed:</label>
        <input
          id="breed"
          type="text"
          class="form-control"
          v-model="cat.breed"
        />
      </div>

      <div class="form-group">
        <label for="lives">Lives Left:</label>
        <input
          id="lives"
          type="text"
          class="form-control"
          v-model="cat.lives"
          required
        />
      </div>

      <div class="form-group">
        <label for="color">Color:</label>
        <input
          id="color"
          type="text"
          class="form-control"
          v-model="cat.color"
          required
        />
      </div>

      <div class="form-group">
        <label for="occupation">Occupation:</label>
        <input
          id="occupation"
          type="text"
          class="form-control"
          v-model="cat.occupation"
          required
        />
      </div>

      <div class="form-group">
        <label for="tagline">Tagline:</label>
        <input
          id="tagline"
          type="text"
          class="form-control"
          v-model="cat.tagline"
          required
        />
      </div>

      <div class="form-group">
        <label for="address">Address:</label>
        <input
          id="address"
          type="text"
          class="form-control"
          v-model="cat.address"
          required
        />
      </div>

      <div class="form-group">
        <label for="summary">Summary:</label>
        <input
          id="summary"
          type="text"
          class="form-control"
          v-model="cat.summary"
          required
        />
      </div>

      

      <button class="btn btn-submit">Submit</button>
      <button class="btn btn-cancel" type="cancel">Cancel</button>
    </form>
  </div>

</template>


<script>

import catService from '../services/CatService';

export default {
  name: "add-cat",

  data() {
    return {
      cat: {
        name: "",
        breed: "",
        lives: "",
        color: "",
        occupation: "",
        tagline: "",
        address: "",
        summary: ""
       
      }
    };
  },
  methods: {

    submitForm() {
       catService.addCat(this.cat).then(response => {
         console.log(response.status);
          if(response.status == '201') {
            
            //success
            this.$router.push('account');
          }
       })
       .catch(error => {
         // handle an error 
         console.log(error);
       })
    }
  }

}
 
</script>

<style scoped>


</style>