#! /bin/env kscript

@file:DependsOn("org.jetbrains.kotlin:kotlin-compiler:1.4.0")
val version = "1.4.0"

val warnings =
        org.jetbrains.kotlin.diagnostics.Errors::class.java.declaredFields
                .map { it.name to it.get(null) as? org.jetbrains.kotlin.diagnostics.DiagnosticFactory<*> }
                .filter { it.second != null }
                .filter { it.second?.severity == org.jetbrains.kotlin.diagnostics.Severity.WARNING }
                .map { it.first }
                .map { """const val $it = "$it" """ }
                .joinToString("\n")

java.io.File("src/main/kotlin/kotlinx/Warnings.kt").bufferedWriter().use {
    it.appendln("package kotlinx.warnings")
    it.appendln()
    it.appendln("object Warnings { ")
    it.appendln(warnings.prependIndent("   "))
    it.appendln("}")
}

val lines = java.io.File("pom.xml").readLines().map {
    Regex("(<kotlin.version>)(.*)(</kotlin.version>)").replace(it) { matchResult ->
        val (pre, _, post) = matchResult.destructured
        "${pre}${version}${post}"
    }
}

java.io.File("pom.xml").printWriter().use { writer -> lines.forEach { writer.println(it) } }

java.lang.ProcessBuilder("mvn", "clean", "deploy").inheritIO().start().waitFor().let(java.lang.System::exit)
