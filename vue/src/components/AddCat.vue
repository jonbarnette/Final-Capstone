<template>
  <!-- <div id="addCatform">
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
  </div> -->
  <div class="container5">
    
    <form action="/action_page.php">
      <label for="fname">Name</label>
      <input type="text" id="fname" name="name" placeholder="Your name.." />
      <label for="lives">Lives</label>
      <input
        type="text"
        id="lives"
        name="lives"
        placeholder="How many lives left.."
      />
      <label for="breed">Breed</label>
      <input type="text" id="breed" name="breed" placeholder="Your breed.." />
      <label for="color">Color</label>
      <input
        type="text"
        id="color"
        name="color"
        placeholder="Your color(s).."
      />
      <label for="occupation">Occupation</label>
      <input
        type="text"
        id="occupation"
        name="occupation"
        placeholder="Your occupation.."
      />
      <label for="address">Address</label>
      <input
        type="text"
        id="address"
        name="address"
        placeholder="Your address.."
      />
      <label for="tagline">Tagline</label>
      <textarea
        id="tagline"
        name="tagline"
        placeholder="Write something.."
        style="height: 100px"
      ></textarea>
      <label for="summary">Summary</label>
      <textarea
        id="summary"
        name="summary"
        placeholder="Write something.."
        style="height: 100px"
      ></textarea>
      <input type="submit" value="Submit" />
    </form>
    
  </div>
</template>


<script>
import catService from "../services/CatService";

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
        summary: "",
      },
    };
  },
  methods: {
    submitForm() {
      catService
        .addCat(this.cat)
        .then((response) => {
          console.log(response.status);
          if (response.status == "201") {
            //success
            this.$router.push("account");
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error);
        });
    },
  },
};
</script>

<style scoped>
* {
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

input[type="text"], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

::placeholder {
  color: black;
}
input[type="submit"] {
  background-color: #4caf50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 10em;
}
input[type="submit"]:hover {
  background-color: #45a049;
}
.container5, form{
  border-radius: 5px;
  background-color: #5680e9;
  padding: 20px;
  font-family: monospace;
  width: 25em;
  margin: 0 auto;
  align-items: center;
}
</style>