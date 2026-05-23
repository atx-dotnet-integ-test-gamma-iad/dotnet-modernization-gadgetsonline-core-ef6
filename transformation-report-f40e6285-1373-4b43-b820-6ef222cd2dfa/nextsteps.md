# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only framework such as `net48`.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's core functionality to confirm that behavior matches the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing logic has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before moving forward.

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer or search the codebase for usages such as:

- `System.Windows.Forms`
- `Microsoft.Win32`
- `System.Drawing` (without the `System.Drawing.Common` NuGet package)
- P/Invoke calls targeting Windows DLLs

Replace or abstract any such usages with cross-platform alternatives where applicable.

### 7. Validate Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent configuration files) have been migrated from `Web.config` / `App.config` and that all connection strings and application settings are present and correct.
- Verify that static files, views, and other content files are included in the project and are being served correctly at runtime.

### 8. Database and Data Access Validation

If the application uses a database:

- Confirm that the connection string in `appsettings.json` points to the correct database instance.
- If Entity Framework is in use, run the following to verify the model is in sync with the database schema:

```bash
dotnet ef migrations list
```

Apply any pending migrations if necessary:

```bash
dotnet ef database update
```

### 9. Review Middleware and HTTP Pipeline

If this is an ASP.NET Core web application, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Authentication and authorization configurations have been correctly migrated.
- Any HTTP modules or HTTP handlers from the legacy project have been replaced with the appropriate ASP.NET Core middleware equivalents.