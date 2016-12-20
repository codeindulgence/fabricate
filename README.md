Fabricate
=========

Description
-----------
Interface to the awesome [Faker](https://github.com/stympy/faker).

Installation
------------
`gem install fabricate`

Synopsis
--------

`$ fabricate COUNT TYPE[,TYPE,...]`

Usage
-----

```
$ fabricate 1 Name,Email,Country,Color.color_name`

Horace Windler,emanuel_funk@kiehn.com,New Caledonia,green
```

Refer to [Faker docs](https://github.com/stympy/faker/blob/master/README.md#usage) for class and method names.

Roadmap to 1.0
--------------

- [ ] Configure custom lang file
- [ ] Pass options to relevant methods
- [ ] Load schema from config file
- [ ] Run on HTTP
- [ ] Run on FTP
- [ ] JSON output
- [ ] XML output

Contributing
------------
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

Credits
-------
[Nick Butler](https://www.codeindulgence.com) <nick@codeindulgence.com>

License
-------
The MIT License (MIT)

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
