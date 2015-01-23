# Traject::SolrJWriter

Use [Traject](http://github.com/traject-project/traject) to write to
a Solr index using the `solrj` java library.

**This gem requires JRuby and Traject >= 2.0**

## Notes on using this gem
  * Our benchmarking indicates that `Traject::SolrJsonWriter` (included with Traject) outperforms
    this library by a notable swath. Use that if you can.
  * If you're running a version of Solr < 3.2, you can't use `SolrJsonWriter` at all; this
    becomes your best bet.
  * Given its reliance on loading `.jar` files, `Traject::SolrJWriter` obviously require JRuby.

## Usage

You'll need to make sure this gem is available (e.g., by putting it in your gemfile)
and then have code like this:

```ruby
# Sample traject configuration for using solrj
require 'traject'
require 'traject/solrj_writer'


settings do
  # Arguments for any solr writer
  provide "solr.url", ENV["SOLR_URL"] | 'http://localhost:8983/solr/core1'
  provide "solr_writer.commit_on_close", "true"
  provide "solr_writer.thread_pool", 2
  provide "solr_writer.batch_size", 50

  # SolrJ Specific stuff
  provide "solrj_writer.parser_class_name", "XMLResponseParser"
  provide "writer_class_name", "Traject::SolrJWriter"

  store 'processing_thread_pool', 5
  store "log.batch_size", 25_000

```

...and then use Traject as normal.


## Full list of settings

### Generic Solr settings (used for both SolrJWriter and SolrJsonWriter)

* `solr.url`: Your solr url (required)
* `solr_writer.commit_on_close`:  If true (or string 'true'), send a commit to solr
  at end of #process.

* `solr_writer.batch_size`:      If non-nil and more than 1, send documents to
  solr in batches of solrj_writer.batch_size. If nil/1,
  however, an http transaction with solr will be done
  per doc. DEFAULT to 100, which seems to be a sweet spot.

* `solr_writer.thread_pool`:      Defaults to 1. A thread pool is used for submitting docs
  to solr. Set to 0 or nil to disable threading. Set to 1,
  there will still be a single bg thread doing the adds. For
  very fast Solr servers and very fast indexing processes, may
  make sense to increase this value to throw at Solr as fast as it
  can catch.

### SolrJ-specific settings

* `solrj_writer.server_class_name`:  Defaults to "HttpSolrServer". You can specify
  another Solr Server sub-class, but it has
  to take a one-arg url constructor. Maybe
  subclass this writer class and overwrite
  instantiate_solr_server! otherwise

* `solrj.jar_dir`: Custom directory containing all of the SolrJ jars. All
  jars in this dir will be loaded. Otherwise,
  we load our own packaged solrj jars. This setting
  can't really be used differently in the same app instance,
  since jars are loaded globally.

* `solrj_writer.parser_class_name`: A String name of a class in package
  org.apache.solr.client.solrj.impl,
  we'll instantiate one with a zero-arg
  constructor, and pass it as an arg to setParser on
  the SolrServer instance, if present.
  NOTE: For contacting a Solr 1.x server, with the
  recent version of SolrJ used by default, set to
  "XMLResponseParser"




## Installation

Add this line to your application's Gemfile:

```ruby
gem 'traject-solrj_writer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traject-solrj_writer


## Contributing

1. Fork it ( https://github.com/traject-project/traject-solrj_writer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
