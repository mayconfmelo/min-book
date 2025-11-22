#import "/src/lib.typ": book

#set page(paper: "a5")
#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (
  title: "Title", subtitle: "Subtitle", authors: "Author", titlepage: none,
  cover: none, toc: none, volume: 1, cfg: (two-sided: false),
)
#let book = book.with(..other, doc)


#book(
  catalog: (
    before: [
      Copyright #sym.copyright 2025 by #other.authors\
      All rights reserved. No part of this publication may be reproduced, stored
      in a retrieval system, or transmitted in any form or by any means—electronic,
      mechanical, photocopying, recording, or otherwise—without the prior written
      permission of the publisher, except in the case of brief quotations embodied
      in critical articles or reviews.
      
      Cover and book design by _min-manual_.\
      Made in Brazil.\
      First edition.
      
      #v(1fr)
      
      #align(center)[*Library of Congress Cataloging-in-Publication Data*]
    ],
    id: "A000",
    place: "Place",
    publisher: "Publisher",
    isbn: "000-0-00-000000-0",
    subjects: ("Book Theme", "Book Subject", "Book Area"),
    access: "Title",
    ddc: "000.00",
    udc: "000.000",
    after: align(center)[
      _Minimal Books_ is a trademark of min-book, registered or pending
      registration in applicable jurisdictions.

      For permission requests, contact the publisher at:\
      permissions\@publisher.com
    ]
  ),
)