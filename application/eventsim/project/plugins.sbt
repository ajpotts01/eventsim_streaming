
resolvers += "sbt-plugin-releases" at "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases"

addSbtPlugin("com.cavorite" % "sbt-avro" % "3.1.0")
libraryDependencies += "org.apache.avro" % "avro-compiler" % "1.10.0"

addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.15.0")

