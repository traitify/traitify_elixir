# Traitify Elixir

An Elixir client library for the Traitify Developer's API

## Using

It is simple to add to any project. If you are using the hex package manager, just add the following to your mix file:

``` elixir
def deps do
  [ { :traitify_elixir, '~> 0.1.1' } ]
end
```

If you aren't using hex, add the a reference to the github repo.

``` elixir
def deps do
  [ { :traitify_elixir, github: "traitify/traitify_elixir" } ]
end
```

Then run `mix deps.get` in the shell to fetch and compile the dependencies.

## Configuration

Next, set the environment variables for the API host and your secret key. You can obtain a secret key from
the [developer portal](http://developer.traitify.com). Once you register on the site, you will be provided
a key as well as information on the API host.

``` bash

$ export TRAITIFY_API_HOST=https://api-sandbox.traitify.com
$ export TRAITIFY_API_KEY=<your_unique_secret_key>

```
## Example Usage

### Decks

Retrieving a list of available decks is simple. Just call the all function on the Client module and pass it `:decks`.

``` shell
$ iex -S mix
iex(1)> decks = Traitify.Client.all(:decks)
```

The all function returns the JSON response body from the Traitify API.

``` shell
iex(2)> deck = List.first(decks)
iex(3)> deck["id"]
"career-deck"
```

### Assessments

Once you have a deck id, you can then create an assessment.

``` shell
iex(4)> assessment = Traitify.Client.create(:assessments, %{deck_id: deck["id"]})
%{"completed_at" => nil, "created_at" => 1414427522010,
  "deck_id" => "career-deck", "id" => "3668590b-f32f-4db0-94e3-d35703b28820",
  "tags" => nil}
```

### Slides

Now that you have an assessment, it's time to get a list of the slides for that assessment

``` shell
iex(5)> slides = Traitify.Client.all(:slides, assessment_id: assessment["id"]})
```

For each slide you can send the user's response or you can send a bulk set of responses. Here is an example of
updating for a single slide:

``` shell
iex(6)> Client.update(:slides, %{response: <user's answer here>, time_taken: 2},
                                 assessment_id: assessment["id"],
                                 slide_id: <slide id here>)
```

### Results

Finally you can retrieve the personality types/traits results for a completed assessment. If the assessment is not complete, you will receive an 'Assessment Not Found' message.

``` shell
iex(7)> personality_types = Traitify.Client.all(:personality_types, [assessment_id: assessment["id"]])
iex(8)> personality_traits = Traitify.Client.all(:personality_traits, [assessment_id: assessment["id"]])
```


### More Examples

You can check out the Elixir [example](http://github.com/traitify/example_elixir) application to get ideas for your own implementation. If you have questions, please contact [support@traitify.com](mailto:support@traitify.com)
