// define the transformer and model to use

import { pipeline } from "@huggingface/transformers";

const pipe = pipeline("text-generation", "meta-llama/Llama-3.2-1B", {
  device: "cpu",
  model_file_name: "model.safetensors",
});
const input = "The quick brown fox jumps over the lazy dog";
const options = {
  max_length: 50,
  num_return_sequences: 1,
  do_sample: true,
  temperature: 0.7,
  top_k: 50,
  top_p: 0.95,
};
