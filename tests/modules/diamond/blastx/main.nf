#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { DIAMOND_MAKEDB } from '../../../../modules/diamond/makedb/main.nf'
include { DIAMOND_BLASTX } from '../../../../modules/diamond/blastx/main.nf'

workflow test_diamond_blastx {

    db = [ file(params.test_data['sarscov2']['genome']['proteome_fasta'], checkIfExists: true) ]
    fasta = [ file(params.test_data['sarscov2']['genome']['transcriptome_fasta'], checkIfExists: true) ]
    outext = 'txt'
    blast_columns = 'qseqid qlen'

    DIAMOND_MAKEDB ( db )
    DIAMOND_BLASTX ( [ [id:'test'], fasta ], DIAMOND_MAKEDB.out.db, outext, blast_columns )
}

workflow test_diamond_blastx_daa {

    db = [ file(params.test_data['sarscov2']['genome']['proteome_fasta'], checkIfExists: true) ]
    fasta = [ file(params.test_data['sarscov2']['genome']['transcriptome_fasta'], checkIfExists: true) ]
    outext = 'daa'
    blast_columns = []

    DIAMOND_MAKEDB ( db )
    DIAMOND_BLASTX ( [ [id:'test'], fasta ], DIAMOND_MAKEDB.out.db, outext, blast_columns )
}
