import 'package:flutter/material.dart';

import 'service/mapping_service.dart';

class PatientScreeningScreen extends StatefulWidget {
  final String programId;
  final String stageId;

  const PatientScreeningScreen({
    required this.programId,
    required this.stageId,
    Key? key,
  }) : super(key: key);

  @override
  _PatientScreeningScreenState createState() => _PatientScreeningScreenState();
}

class _PatientScreeningScreenState extends State<PatientScreeningScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _mappingService = MappingService();
  Map<String, dynamic> _mappedData = {};
  bool _isLoading = false;

  Future<void> _loadSharedData() async {
    setState(() => _isLoading = true);
    
    try {
      // Simulate fetching data from another program
      final vitalsData = {
        'Height': '175',  // Would come from Person Register → Vitals
        'Weight': '68',   // Would come from Person Register → Vitals
      };

      _mappedData = await _mappingService.mapDataAutomatically(
        triggerProgramId: widget.programId,
        triggerStageId: widget.stageId,
        inputData: vitalsData,
      );

      // Auto-populate fields if mapped data exists
      if (_mappedData.containsKey('Patient Height')) {
        _heightController.text = _mappedData['Patient Height'];
      }
      if (_mappedData.containsKey('Patient Weight')) {
        _weightController.text = _mappedData['Patient Weight'];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading shared data: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSharedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial Screening'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        suffixText: 'cm',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Required' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        suffixText: 'kg',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Required' : null,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Save Screening'),
                    ),
                    if (_mappedData.isNotEmpty) ...[
                      SizedBox(height: 24),
                      Text(
                        'Auto-populated from shared data:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        _mappedData.entries
                            .map((e) => '${e.key}: ${e.value}')
                            .join('\n'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process form submission
      final formData = {
        'Patient Height': _heightController.text,
        'Patient Weight': _weightController.text,
      };
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Screening data saved successfully')),
      );
      
      // Here you would typically save to DHIS2
      debugPrint('Submitting data: $formData');
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}