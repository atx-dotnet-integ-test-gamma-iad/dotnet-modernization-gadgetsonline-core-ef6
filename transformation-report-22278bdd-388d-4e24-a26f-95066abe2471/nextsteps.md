# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, such as `net8.0`. Ensure it is not targeting `net5.0` or `net6.0`, as those are out of support.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's core functionality to verify that behavior matches the legacy version.

### 5. Check for Runtime Errors

Pay close attention to any runtime exceptions that would not surface at compile time. Common areas to check after a cross-platform migration include:

- **File path separators**: Ensure no hardcoded backslashes (`\`) are used in file path logic. Use `Path.Combine` or `Path.DirectorySeparatorChar` instead.
- **Case-sensitive file systems**: Linux and macOS file systems are case-sensitive. Verify that file references, view names, and static asset paths use consistent casing.
- **Registry or Windows-specific APIs**: Confirm that no code references `Microsoft.Win32` or other Windows-only namespaces that would fail on Linux or macOS.

### 6. Review Configuration Files

Check `appsettings.json` and any environment-specific variants (`appsettings.Development.json`, etc.) to ensure:

- Connection strings are updated for the target environment.
- Any paths or environment-specific values have been reviewed.

### 7. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results and address any failing tests before proceeding.

### 8. Verify Static Assets and Views

If this is a web application, load the application in a browser and verify:

- Static files (CSS, JavaScript, images) are served correctly.
- All views render without errors.
- Form submissions and data operations function as expected.

### 9. Check Database Migrations

If the project uses Entity Framework Core, verify that migrations are compatible with the new framework version:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

If migrations are out of date or missing, create a new migration and apply it to the target database:

```bash
dotnet ef migrations add <MigrationName> --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.