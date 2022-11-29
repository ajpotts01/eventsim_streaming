name := "eventsim"

version := "2.0"

scalaVersion := "2.12.10"

// resolvers += Resolver.url("confluent", url("http://packages.confluent.io/maven"))

libraryDependencies += "org.apache.avro" % "avro" % "1.10.0"

libraryDependencies += "org.apache.commons" % "commons-math3" % "3.6"

libraryDependencies += "de.jollyday" % "jollyday" % "0.5.1"

libraryDependencies += "org.rogach" % "scallop_2.12" % "3.5.1"

libraryDependencies += "com.fasterxml.jackson.core" % "jackson-core" % "2.11.3"

libraryDependencies += "com.fasterxml.jackson.core" % "jackson-databind" % "2.11.3"

libraryDependencies += "org.apache.kafka" % "kafka-clients" % "2.6.0"

libraryDependencies += "org.scala-lang.modules" % "scala-parser-combinators_2.12" % "1.1.2"

libraryDependencies += "com.sun.xml.bind" % "jaxb-impl" % "2.3.3"


// libraryDependencies += "io.confluent" % "kafka-avro-serializer" % "2.0.0"

// seq( sbtavro.SbtAvro.avroSettings : _*)

mergeStrategy in assembly ~= ( (old) => {
    case PathList("module-info.class" ) => MergeStrategy.discard
    case PathList("javax", "xml", "bind", ps @ _*) => MergeStrategy.first
    case x => old(x)
  }
)
