apply {
    arp_icmp.apply();
}
apply {
    update_and_check_worker_bitmap.apply();
}
apply {
    exponent_max.apply();
}
apply {
    forward.apply();
}
apply {
    // If this is a SwitchML packet
    // get worker masks, pool base index, other parameters for this packet
    // add switchml_md header if it isn't already added
    // (do only on first pipeline pass, not on recirculated CONSUME passes)
    if (ig_md.switchml_md.packet_type == packet_type_t.CONSUME0) {

        // if (hdr.ib_bth.isValid()) {
        //     rdma_receiver.apply(hdr, ig_md, ig_intr_md, ig_prsr_md, ig_dprsr_md, ig_tm_md);
        // } else {
        //     udp_receiver.apply(hdr, ig_md, ig_intr_md, ig_prsr_md, ig_dprsr_md, ig_tm_md);
        // }

        // Simulate ingress packet drops
        // ingress_drop_sim.apply(ig_md.port_metadata);

        // Set bit to simulate packet drops in egress
        // egress_drop_sim.apply(ig_md.port_metadata, QP_INDEX, ig_md.switchml_md.simulate_egress_drop);

        // Store original ingress port to be used in retransmissions
        ig_md.switchml_md.ingress_port = ig_intr_md.ingress_port;
    }
    // else if (ig_md.switchml_md.packet_type == packet_type_t.CONSUME1 ||
    //     ig_md.switchml_md.packet_type == packet_type_t.CONSUME2 ||
    //     ig_md.switchml_md.packet_type == packet_type_t.CONSUME3) {
    //     reconstruct_worker_bitmap.apply(ig_md);
    // }

    // If the packet is valid, should be either forwarded or processed
    if (ig_dprsr_md.drop_ctl[0:0] == 1w0) {
        if (ig_md.switchml_md.packet_type == packet_type_t.CONSUME0)
        //   || ig_md.switchml_md.packet_type == packet_type_t.CONSUME1
        //   || ig_md.switchml_md.packet_type == packet_type_t.CONSUME2
        //   || ig_md.switchml_md.packet_type == packet_type_t.CONSUME3) 
        {
            // For CONSUME packets, record packet reception and check if this packet is a retransmission
            update_and_check_worker_bitmap.apply(hdr, ig_md, ig_intr_md, ig_dprsr_md, ig_tm_md);

            // Detect when we have received all the packets for a slot
            workers_counter.apply(hdr, ig_md, ig_dprsr_md);
        }

        // If it's a SwitchML packet, process it
        if ((packet_type_underlying_t) ig_md.switchml_md.packet_type >=
            (packet_type_underlying_t) packet_type_t.CONSUME0) { // all consume or harvest types

            // Update/read exponents if this is a packet with exponents
            if (ig_md.switchml_md.last_packet) {
                exponents.apply(
                    ig_md.switchml_md.e0, ig_md.switchml_md.e1,
                    ig_md.switchml_md.e0, ig_md.switchml_md.e1,
                    ig_md);
            }

            // Aggregate values
            value00.apply(hdr.d0.d00, hdr.d1.d00, hdr.d0.d00, hdr.d1.d00, ig_md.switchml_md);
            value01.apply(hdr.d0.d01, hdr.d1.d01, hdr.d0.d01, hdr.d1.d01, ig_md.switchml_md);
            value02.apply(hdr.d0.d02, hdr.d1.d02, hdr.d0.d02, hdr.d1.d02, ig_md.switchml_md);
            value03.apply(hdr.d0.d03, hdr.d1.d03, hdr.d0.d03, hdr.d1.d03, ig_md.switchml_md);
            value04.apply(hdr.d0.d04, hdr.d1.d04, hdr.d0.d04, hdr.d1.d04, ig_md.switchml_md);
            value05.apply(hdr.d0.d05, hdr.d1.d05, hdr.d0.d05, hdr.d1.d05, ig_md.switchml_md);
            value06.apply(hdr.d0.d06, hdr.d1.d06, hdr.d0.d06, hdr.d1.d06, ig_md.switchml_md);
            value07.apply(hdr.d0.d07, hdr.d1.d07, hdr.d0.d07, hdr.d1.d07, ig_md.switchml_md);
            value08.apply(hdr.d0.d08, hdr.d1.d08, hdr.d0.d08, hdr.d1.d08, ig_md.switchml_md);
            value09.apply(hdr.d0.d09, hdr.d1.d09, hdr.d0.d09, hdr.d1.d09, ig_md.switchml_md);
            value10.apply(hdr.d0.d10, hdr.d1.d10, hdr.d0.d10, hdr.d1.d10, ig_md.switchml_md);
            value11.apply(hdr.d0.d11, hdr.d1.d11, hdr.d0.d11, hdr.d1.d11, ig_md.switchml_md);
            value12.apply(hdr.d0.d12, hdr.d1.d12, hdr.d0.d12, hdr.d1.d12, ig_md.switchml_md);
            value13.apply(hdr.d0.d13, hdr.d1.d13, hdr.d0.d13, hdr.d1.d13, ig_md.switchml_md);
            value14.apply(hdr.d0.d14, hdr.d1.d14, hdr.d0.d14, hdr.d1.d14, ig_md.switchml_md);
            value15.apply(hdr.d0.d15, hdr.d1.d15, hdr.d0.d15, hdr.d1.d15, ig_md.switchml_md);
            value16.apply(hdr.d0.d16, hdr.d1.d16, hdr.d0.d16, hdr.d1.d16, ig_md.switchml_md);
            value17.apply(hdr.d0.d17, hdr.d1.d17, hdr.d0.d17, hdr.d1.d17, ig_md.switchml_md);
            value18.apply(hdr.d0.d18, hdr.d1.d18, hdr.d0.d18, hdr.d1.d18, ig_md.switchml_md);
            value19.apply(hdr.d0.d19, hdr.d1.d19, hdr.d0.d19, hdr.d1.d19, ig_md.switchml_md);
            value20.apply(hdr.d0.d20, hdr.d1.d20, hdr.d0.d20, hdr.d1.d20, ig_md.switchml_md);
            value21.apply(hdr.d0.d21, hdr.d1.d21, hdr.d0.d21, hdr.d1.d21, ig_md.switchml_md);
            value22.apply(hdr.d0.d22, hdr.d1.d22, hdr.d0.d22, hdr.d1.d22, ig_md.switchml_md);
            value23.apply(hdr.d0.d23, hdr.d1.d23, hdr.d0.d23, hdr.d1.d23, ig_md.switchml_md);
            value24.apply(hdr.d0.d24, hdr.d1.d24, hdr.d0.d24, hdr.d1.d24, ig_md.switchml_md);
            value25.apply(hdr.d0.d25, hdr.d1.d25, hdr.d0.d25, hdr.d1.d25, ig_md.switchml_md);
            value26.apply(hdr.d0.d26, hdr.d1.d26, hdr.d0.d26, hdr.d1.d26, ig_md.switchml_md);
            value27.apply(hdr.d0.d27, hdr.d1.d27, hdr.d0.d27, hdr.d1.d27, ig_md.switchml_md);
            value28.apply(hdr.d0.d28, hdr.d1.d28, hdr.d0.d28, hdr.d1.d28, ig_md.switchml_md);
            value29.apply(hdr.d0.d29, hdr.d1.d29, hdr.d0.d29, hdr.d1.d29, ig_md.switchml_md);
            value30.apply(hdr.d0.d30, hdr.d1.d30, hdr.d0.d30, hdr.d1.d30, ig_md.switchml_md);
            value31.apply(hdr.d0.d31, hdr.d1.d31, hdr.d0.d31, hdr.d1.d31, ig_md.switchml_md);

            // Decide what to do with this packet
            next_step_selector.apply(hdr, ig_md, ig_intr_md, ig_dprsr_md, ig_tm_md);
        } else {
            // Handle ARP and ICMP requests
            arp_icmp_responder.apply(hdr, ig_md, ig_intr_md, ig_prsr_md, ig_dprsr_md, ig_tm_md);

            // Process other regular traffic
            forwarder.apply(hdr, ig_md, ig_intr_md, ig_dprsr_md, ig_tm_md);
        }
    }
}
apply {
    if (eg_md.switchml_md.packet_type == packet_type_t.BROADCAST ||
        eg_md.switchml_md.packet_type == packet_type_t.RETRANSMIT) {

        // Simulate packet drops
        if (eg_md.switchml_md.simulate_egress_drop) {
            eg_md.switchml_md.packet_type = packet_type_t.IGNORE;
            eg_intr_dprs_md.drop_ctl[0:0] = 1;
        }

        // If it's BROADCAST, copy rid from PRE to worker id field
        // so tables see it
        if (eg_md.switchml_md.packet_type == packet_type_t.BROADCAST) {
            eg_md.switchml_md.worker_id = eg_intr_md.egress_rid;
        }

        // if (eg_md.switchml_md.worker_type == worker_type_t.ROCEv2) {
        //     rdma_sender.apply(hdr, eg_md, eg_intr_md, eg_intr_md_from_prsr, eg_intr_dprs_md);
        // } else {
            udp_sender.apply(eg_md, eg_intr_md, hdr);
        // }
    }
}
apply {

    // count_consume = false;
    // count_broadcast = false;
    // count_retransmit = false;
    // count_recirculate = false;
    // count_drop = false;

    next_step.apply();

    // Update counters
    // if (count_consume || count_drop) {
    //     drop_counter.count(ig_md.switchml_md.pool_index);
    // }

    // if (count_recirculate) {
    //     recirculate_counter.count(ig_md.switchml_md.pool_index);
    // }

    // if (count_broadcast) {
    //     broadcast_counter.count(ig_md.switchml_md.pool_index);
    // }

    // if (count_retransmit) {
    //     retransmit_counter.count(ig_md.switchml_md.pool_index);
    // }
}
apply {
    sum.apply();
}
apply {
    receive_udp.apply();
}
apply {
    hdr.ethernet.setValid();
    hdr.ipv4.setValid();
    hdr.udp.setValid();
    hdr.switchml.setValid();
    hdr.switchml.pool_index = 16w0;

    switch_mac_and_ip.apply();
    dst_addr.apply();

    // Add payload size
    if (eg_md.switchml_md.packet_size == packet_size_t.IBV_MTU_256) {
        hdr.ipv4.total_len = hdr.ipv4.total_len + 256;
        hdr.udp.length = hdr.udp.length + 256;
    }
    else if (eg_md.switchml_md.packet_size == packet_size_t.IBV_MTU_1024) {
        hdr.ipv4.total_len = hdr.ipv4.total_len + 1024;
        hdr.udp.length = hdr.udp.length + 1024;
    }
}
apply {
    count_workers.apply();
}